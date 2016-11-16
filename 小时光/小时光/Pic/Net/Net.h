//
//  Net.h
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^success) (id response);
typedef void(^fail) (NSError* error);
@interface Net : NSObject
+(void)GetImageUrs:(int)pageindex id:(int)Id success:(success)success fail:(fail)fail;
+(void)tt;
+(void)ttt;
+(void)cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(id)anArgument;
TTY_BI
---
//test merge
1
2
3
4
5
6
7
8
88888
@end
