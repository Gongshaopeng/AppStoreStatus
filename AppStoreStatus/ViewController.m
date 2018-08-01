//
//  ViewController.m
//  AppStoreStatus
//
//  Created by 巩小鹏 on 2018/7/31.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ViewController.h"
#import "AppStoreManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
