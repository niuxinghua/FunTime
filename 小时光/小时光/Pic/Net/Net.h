//
//  Net.h
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//test
typedef void(^success) (id response);
typedef void(^fail) (NSError* error);
@interface Net : NSObject
+(void)GetImageUrs:(int)pageindex id:(int)Id success:(success)success fail:(fail)fail;
@end
