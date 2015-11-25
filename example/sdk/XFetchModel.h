//
//  XFetchModel.h
//  XStaiticLibrary
//
//  Created by clio on 15/9/9.
//  Copyright (c) 2015年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  请求完成的回调
 *
 *  @param isSucceeded 成功返回YES, 失败返回NO
 *  @param error       错误信息
 */
typedef void (^FetchCompletionHandler) (BOOL isSucceeded, NSError *error);

@interface XFetchModel : NSObject
/**
 *  错误信息（用于开发者调试）
 */
@property(nonatomic,copy) NSString *details;
/**
 *  错误码
 */
@property(nonatomic,copy)NSNumber *status;
/**
 *  给用户的信息
 */
@property (nonatomic, copy) NSString *msg;
/**
 *  请求参数
 */
@property(nonatomic,strong)NSDictionary *requestParams;

/**
 *  请求数据
 *
 *  @param path    接口
 *  @param handler 请求完成的block
 */
- (void)fetchWithPath:(NSString *)path completionHandler:(FetchCompletionHandler)handler;
/**
 *  相关映射
 */
-(NSDictionary *)modelKeyJSONKeyMapper;
/**
 *  加载图片
 *
 *  @param imgUrl    图片的URL
 *  @param image     默认加载的图片
 *  @param imageView 图片
 */
- (void)setImageWithURL:(NSURL *)imgUrl placeHolderImage:(UIImage *)image withImageView:(UIImageView *)imageView;
@end
