//
//  Net.m
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import "Net.h"
#import "Header.h"
@implementation Net
+(void)GetImageUrs:(NSString *)month Day:(NSString *)day success:(success)success fail:(fail)fail{
    static AFHTTPRequestOperationManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
    NSString* url=[NSString stringWithFormat:@"%@/福利/10/1",PIC_Url];
    NSLog(@"%@",url);
    [manager GET:@"http://www.tngou.net/tnfs/api/list" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail(error);
    }];
}





@end
