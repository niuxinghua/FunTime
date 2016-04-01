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
+(void)GetImageUrs:(int)pageindex id:(int)Id success:(success)success fail:(fail)fail{
    static AFHTTPRequestOperationManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
   
    NSDictionary* dic=@{@"page":[NSNumber numberWithInt:pageindex],@"rows":@"30",@"id":[NSNumber numberWithInt:Id]};
    [manager GET:@"http://www.tngou.net/tnfs/api/list" parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail(error);
    }];
}





@end
