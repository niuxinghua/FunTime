//
//  NXPicViewController.h
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXPicViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *datalist;
@end
