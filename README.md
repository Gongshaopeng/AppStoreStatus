# AppStoreStatus

#### 项目介绍

最近开发项目有些功能需要上线才能打开（避免审核中的无效功能，被拒），临时写了一个管理类，AppStoreManager 来监控和区分线上的几种状态（未发布、更新、未更新），一句话来解决麻烦。

其实原理很简单获取本地版本号version，然后通过 itunes 的请求地址来获取当前AppStore上的状态，获取info.plist里面的 version 来进行判断，以下是 itunes 地址。
 http://itunes.apple.com/lookup?id=%@




#### 依赖库：

AFNetworking



#### 使用说明
+ 引用头文件
```
#import "AppStoreManager.h"
```
+ 使用一下方法
```
  [[AppStoreManager defaultManager] updateVersionWithAppID:@"这里写AppStore里的ID" complete:^(AppStoreType appStoreType ) {
        switch (appStoreType) {
                case appStoreTypeNot:
            {
  
            }
                break;
                case appStoreTypeUpdata:
            {

            }
                break;
                case appStoreTypeNormal:
            {
  
            }
                break;
                case appStoreTypeRequestError:
            {
            
            
            }
                break;
            default:
                break;
        }
  
    }];
```



