//
//  XPay.h
//  Xpay
//
//  Created by S on 15/9/8.
//  Copyright (c) 2015年 S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/**
 *  支付返回状态
 */
typedef NS_ENUM(NSInteger, XPayResultStatus) {
    XPAY_SUCCESS    = 100,      // 支付成功
    XPAY_PENDING    = 101,      // 支付结果确认中
    XPAY_CANCELED   = 102,      // 支付取消
    XPAY_FAILED     = 103,      // 支付失败
    XPAY_INVALID    = 104       // 调起支付错误
};



@interface XPayObject : NSObject
/**
 *  支付方式名称
 */
@property (nonatomic,copy) NSString * name;
/**
 *  平台appId
 */
@property (nonatomic,copy) NSString * appId;
/**
 *  图标
 */
@property (nonatomic,copy) NSString * icon;
/**
 *  支付方式
 */
@property (nonatomic,copy) NSString * channel;
@end



#pragma mark - XPay错误对象
@interface XPayError : NSObject
/**
 *  错误信息
 */
@property (nonatomic,copy) NSString * codeMessage;
/**
 *  错误code
 */
@property (nonatomic,assign) NSInteger code;
@end


/**
 *  支付结果回调
 *
 *  @param status 支付结果状态
 *  @param memo   支付结果备注信息
 *  @param attach 额外信息
 */
typedef void(^XPayCompletion)(XPayResultStatus status, NSString * memo, NSObject * attach);
/**
 *  支付渠道列表回调
 *
 *  @param payList 返回当前SDK所支持的支付渠道
 *  @param error   错误信息
 */
typedef void(^XPayListCompletion)(NSArray * payList,XPayError * error);



#pragma mark - XPay支付
@interface XPay : NSObject
/**
 *  创建Xpay对象
 *
 *  @return 返回一个XPay对象
 */
+ (XPay *)share;

/**
 *  支付调用接口(支付宝/微信)
 *
 *  @param charge     Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param completion 支付结果回调 Block
 */
+ (void)pay:(NSObject *)charge withCompletion:(XPayCompletion)completion;

/**
 *  支付调用接口(支付宝/微信)
 *
 *  @param charge     Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param scheme     URL Scheme，支付宝渠道回调需要 (如果传入Scheme，将会使用此url进行支付宝回调，创建订单时传入的Scheme将失效)
 *  @param completion 支付结果回调 Block
 */
+ (void)pay:(NSObject *)charge appURLScheme:(NSString *)scheme withCompletion:(XPayCompletion)completion;

/**
 *  支付调用接口(银联/百度钱包)
 *
 *  @param charge     Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param viewController     银联/百度钱包需要 (不能为空)
 *  @param completion 支付结果回调 Block
 */
+ (void)pay:(NSObject *)charge viewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion;

/**
 *  支付调用接口
 *
 *  @param charge     Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param scheme     URL Scheme，支付宝渠道回调需要 (如果传入Scheme，将会使用此url进行支付宝回调，创建订单时传入的Scheme将失效)
 *  @param viewController     银联/百度钱包需要 (不能为空)
 *  @param completion 支付结果回调 Block
 */
+ (void)pay:(NSObject *)charge appURLScheme:(NSString *)scheme viewController:(UIViewController *)viewController withCompletion:(XPayCompletion)completion;

/**
 *  回调结果接口(支付宝/微信)
 *
 *  @param url        调起url
 *  @param completion 支付结果回调 Block，保证跳转支付过程中，当 app 被 kill 掉时，能通过这个接口得到支付结果
 */
+ (void)handleOpenURL:(NSURL *)url withCompletion:(XPayCompletion)completion;

/**
 *  获取当前XPaySDK的版本号
 *
 *  @return 返回当前XPaySDK的版本号
 */
+ (NSString *)getApiVersion;

/**
 *  设置百度钱包导航条背景
 */
+ (void)setBdWalletNavBgImage:(UIImage *)image;

/**
 *  设置百度钱包返回键Normal图像
 */
+ (void)setBdWalletNavBackNormalImage:(UIImage *)image;

/**
 *  设置百度钱包Title颜色
 */
+ (void)setBdWalletNavTitleColor:(UIColor *)color;


@end
