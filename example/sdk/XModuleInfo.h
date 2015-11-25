//
//  XModuleInfo.h
//  OEProductSDK
//
//  Created by chiyou on 15/9/25.
//  Copyright © 2015年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XModuleInfo : NSObject
/**
 *  保存模块信息的单例
 *
 *  @return 返回一个单例对象
 */
+ (instancetype)shareInstance;
/**
 *  商品模块的appId
 */
@property (nonatomic, copy) NSString *productAppId;
/**
 *  交易模块的appId
 */
@property (nonatomic, copy) NSString *tradeAppId;
/**
 *  支付模块的appId
 */
@property (nonatomic, copy) NSString *payAppId;
/**
 *  是否为debug模式
 */
@property (nonatomic, assign) BOOL  isDebug;


@property (nonatomic, copy) NSString *baseURL;

@end
