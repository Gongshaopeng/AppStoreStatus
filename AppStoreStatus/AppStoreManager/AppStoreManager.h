//
//  AppStoreManager.h
//  emark
//
//  Created by 巩小鹏 on 2018/7/30.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppStoreType){
    appStoreTypeNot = 0,//未上线
    appStoreTypeUpdata = 1,//更新
    appStoreTypeNormal = 2,//未更新
    appStoreTypeRequestError = 3,//请求错误
};

@interface AppStoreManager : NSObject

+(instancetype)defaultManager;
- (void)updateVersionWithAppID:(NSString *)appID complete:(void (^)(AppStoreType appStoreType))complete;

@end
