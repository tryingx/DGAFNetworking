//
//  ViewController.m
//  DGAFNetworking
//
//  Created by Gavin on 16/3/13.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "ViewController.h"

#import "DGAFNetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 通常放在appdelegate就可以了
    [DGAFNetworkManager updateBaseUrl:@"http://apistore.baidu.com"];
    [DGAFNetworkManager enableInterfaceDebug:YES];
    
    /*
     [DGAFNetworkManager.m：in line: 189]-->[message:
     absoluteUrl: http://apistore.baidu.com/microservice/cityinfo?cityname=%E5%8C%97%E4%BA%AC
     params:(null)
     response:{
     errNum = 0;
     retData =     {
     cityCode = 101010100;
     cityName = "\U5317\U4eac";
     provinceName = "\U5317\U4eac";
     telAreaCode = 010;
     zipCode = 100000;
     };
     retMsg = success;
     }
     ]
     */
    
    // 测试GET API
    NSString *url = @"http://apistore.baidu.com/microservice/cityinfo?cityname=beijing";
    //   设置请求类型为text/html类型
    //  [DGAFNetworkManager configRequestType:kHYBRequestTypePlainText];
    //  [DGAFNetworkManager configResponseType:kHYBResponseTypeData];
    [DGAFNetworkManager getWithUrl:url params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"progress: %f, cur: %lld, total: %lld",
              (bytesRead * 1.0) / totalBytesRead,
              bytesRead,
              totalBytesRead);
    } success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    
    // 测试POST API：
    // 假数据
    NSDictionary *postDict = @{ @"urls": @"http://www.henishuo.com/git-use-inwork/",
                                @"goal" : @"site",
                                @"total" : @(123)
                                };
    NSString *path = @"/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp";
    // 由于这里有两套基础路径，用时就需要更新
    [DGAFNetworkManager updateBaseUrl:@"http://data.zz.baidu.com"];
    [DGAFNetworkManager postWithUrl:path params:postDict success:^(id response) {
        NSLog(@"%@",response);
    } fail:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
