//
//  ViewController.m
//  XPay
//
//  Created by S on 15/9/22.
//  Copyright © 2015年 S. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "XPay.h"


//  支付宝支付后同步页面跳转地址
#define alipayReturnUrl     @"123abc"

// 你的服务端创建并返回 charge 的 URL 地址
#define urlStr            @"http://api.kkkd.com/payDemo/chargeSubmit.jsp"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArr;
    
    NSMutableURLRequest * request;
    NSURLSession * session;
    
    NSString * partnerTradeNo;
    NSString * channel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self loadUI];
    
}

- (void)loadData {
    _dataArr = @[@"微信支付",@"支付宝支付",@"百度钱包",@"银联支付"];
}

- (void)loadUI {
    __weak typeof(self) wself = self;
    
    UILabel * footerLabel = [UILabel new];
    footerLabel.text = @"@版权归XPay所有，如有问题请联系我们\n http://www.kkkd.com/home";
    footerLabel.numberOfLines = 0;
    footerLabel.textColor = [UIColor grayColor];
    footerLabel.font = [UIFont systemFontOfSize:14];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:footerLabel];
    [footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.equalTo(wself.view).offset(-60);
        make.width.equalTo(wself.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    _tableView = [UITableView new];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wself.view);
        make.width.equalTo(wself.view);
        make.height.equalTo(wself.view).offset(-100);
    }];
}

#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        // 微信
        channel = @"WXPAY_APP";
    }else if (indexPath.row == 1) {
        channel = @"ALIPAY_APP";
    }else if (indexPath.row == 2) {
        channel = @"BFBPAY_APP";
    }else if (indexPath.row == 3) {
        channel = @"UNIONPAY_APP";
    }
    
    [self sendRequest:indexPath.row];
}

#pragma mark - 获取charge，调起支付

- (void)sendRequest:(NSInteger)row {
    
    // 模拟订单号
    partnerTradeNo = [NSString stringWithFormat:@"%d",arc4random()%100000+100000];
    
    
    NSDictionary * tempDict = @{
                                @"partnerTradeNo":partnerTradeNo,                          // 商户自己系统的订单号                                 (必填)
                                @"title":@"测试",                                          // 商户订单标题                                        (必填)
                                @"channel":channel,                                       // 支付渠道                                            (必填)
                                @"amount":[NSNumber numberWithInt:1],                     // 总支付金额.分为单位，未计算优惠 (long)                  (必填)
                                };
    


    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:tempDict];
    if (row == 1) {
        // 支付宝 -- 支付后同步页面跳转地址
        [dict setObject:alipayReturnUrl forKey:@"alipayReturnUrl"];        // --   (选填)
    }
    
    NSLog(@"%@",dict);
    // 模拟下单
    
    NSMutableString * temptUrl = [NSMutableString string];
    for (NSString * key in [dict allKeys]) {
        [temptUrl appendFormat:@"%@=%@&",key,[dict objectForKey:key]];
    }
    NSString * bodyData = [temptUrl substringToIndex:temptUrl.length-1];
    NSString * urls = [NSString stringWithFormat:@"%@?%@",urlStr,bodyData];
    NSLog(@"url -- %@",urls);
    urls = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urls];
    
    request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    
    session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if (!data) {
            NSLog(@"chargeData can't be nil");
            return ;
        }
        
        if (httpResponse.statusCode != 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertMessage:@"连接失败"];
            });
            return;
        }
        if (error != nil) {
            NSLog(@"error = %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertMessage:@"连接失败"];
            });
            return;
        }
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@",dict);
        int status = [[dict objectForKey:@"status"] intValue];
        if (status != 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertMessage:[dict objectForKey:@"details"]];
            });
            return;
        }

        
        NSDictionary * charge = [dict objectForKey:@"data"];
        
        if (charge == nil || [charge isEqual:@""] || [charge isEqual:@"<null>"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertMessage:[dict objectForKey:@"details"]];
            });
            return;
        }
        
        
        [XPay pay:charge appURLScheme:nil viewController:self withCompletion:^(XPayResultStatus status, NSString *memo, NSObject *attach) {
            NSLog(@"status -- %ld",(long)status);
            NSLog(@"memo -- %@",memo);
            NSLog(@"attach -- %@",attach);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertMessage:memo];
                return;
            });
        }];

        
    }];
    
    [task resume];
    
}

- (void)showAlertMessage:(NSString*)msg
{
    UIAlertView * mAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [mAlert show];
    
}

- (BOOL)isEmpty:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
        string = [string description];
    if (string == nil || string == NULL)
        return YES;
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        return YES;
    if ([string isEqualToString:@"(null)"])
        return YES;
    if ([string isEqualToString:@"(null)(null)"])
        return YES;
    if ([string isEqualToString:@"<null>"])
        return YES;
    
    // return Default
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
