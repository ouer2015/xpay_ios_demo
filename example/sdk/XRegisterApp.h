//
//  XRegisterModel.h
//  OEProductSDK
//
//  Created by chiyou on 15/9/25.
//  Copyright © 2015年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XModuleType) {
    XModuleProduct = 0,      //商品模块
    XModuleTrade   = 1,      //交易模块
    XModulePay     = 2,      //支付模块
    XModuleAll     = 3       //所有的模块（如果三个模块同时引用，且appId相同）
};

@interface XRegisterApp : NSObject
/**
 *  创建一个注册应用对象单例
 *
 *  @return 返回注册应用对象的单例
 */
+ (instancetype)shareInstance;

/**
 *  注册应用
 *
 *  @param appId      在开发者中心生成的appID
 *  @param isDebug    是否为调试模式
 *  @param moduleType 模块的类型
 */
- (void)registerWithAppId:(NSString *)appId isDeug:(BOOL)isDebug withModuleType:(XModuleType)moduleType;
/**
 *  设置环境
 *
 *  @param isRelease YES代表线上, NO代表测试
 */
- (void)setEnvironmentIsRelease:(BOOL)isRelease;
@end
