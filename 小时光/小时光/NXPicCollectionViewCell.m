//
//  NXPicCollectionViewCell.m
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import "NXPicCollectionViewCell.h"
#import "Masonry.h"
@implementation NXPicCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _PicView=[UIImageView new];
        [self.contentView addSubview:_PicView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_PicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.contentView);
    }];
}
@end
