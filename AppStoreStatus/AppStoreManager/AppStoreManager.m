//
//  AppStoreManager.m
//  emark
//
//  Created by 巩小鹏 on 2018/7/30.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "AppStoreManager.h"
#import "AFNetworking.h"
@interface AppStoreManager ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end
@implementation AppStoreManager
+(instancetype)defaultManager{
    static AppStoreManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (manager==nil)
                      {
                          manager=[[AppStoreManager alloc]init];
                      }
                  });
    return manager;
}
-(id)init{
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return self;
}


#pragma mark - 检查版本

- (void)updateVersionWithAppID:(NSString *)appID complete:(void (^)(AppStoreType appStoreType))complete {
    
    // 获取本地版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]; // 就是在info.plist里面的 version
    // 取得AppStore信息
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@", appID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.manager  GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject --- %@", responseObject);
        NSString * AppStoreVersionG;
        NSString * trackViewUrl;
        
        NSArray *resultArr = responseObject[@"results"];
        if(resultArr.count != 0){
            NSDictionary *resultsDict = resultArr.firstObject;
            // 取更新日志信息
            NSString *changeStr = resultsDict[@"releaseNotes"];
            // app store 最新版本号
            AppStoreVersionG = resultsDict[@"version"];
            // app store 跳转版本链接
            trackViewUrl = resultsDict[@"trackViewUrl"];
            NSLog(@"app store 的更新信息 --- %@， app store 的最新版本号 --- %@", changeStr, AppStoreVersionG);
            
            // AppStore版本号大于当前版本号，强制更新
            if ([AppStoreVersionG compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                //  更新
                complete(appStoreTypeUpdata);

            } else {
                // 正常进入程序 未更新
                complete(appStoreTypeNormal);

            }
        }else{
            //未上线
            complete(appStoreTypeNot);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络异常时，正常进入程序
        complete(appStoreTypeRequestError);

    }];
}
@end
