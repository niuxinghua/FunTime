//
//  NXPicViewController.m
//  小时光
//
//  Created by niuxinghua on 16/3/31.
//  Copyright © 2016年 com.hjojo. All rights reserved.
//

#import "NXPicViewController.h"
#import "Masonry.h"
#import "NXPicCollectionViewCell.h"
#import "Net.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface NXPicViewController (){
    int pageindex;
}

@end

@implementation NXPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"妹子";
    self.automaticallyAdjustsScrollViewInsets=NO;
    _datalist=[NSMutableArray new];
    [self setUpUI];
    pageindex=1;
    _collection.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [_collection.mj_header beginRefreshing];
    _collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
-(void)getData{
    pageindex=1;
    [Net GetImageUrs:pageindex id:1  success:^(id response) {
        NSLog(@"%@",response);
        _datalist=[NSMutableArray arrayWithArray:[response objectForKey:@"tngou"]];
        [_collection reloadData];
        [_collection.mj_header endRefreshing];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [_collection.mj_header endRefreshing];
    }];
}
-(void)loadMoreData{
    pageindex++;
    
    [Net GetImageUrs:pageindex id:1  success:^(id response) {
        NSLog(@"%@",response);
        NSArray* data=[response objectForKey:@"tngou"];
        if (data) {
            for (int i=0; i<[data count]; i++) {
                [_datalist addObject:data[i]];
            }
        }
        
        [_collection reloadData];
        [_collection.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [_collection.mj_footer endRefreshing];
    }];
    
}
-(void)setUpUI{
    
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
    _collection=[[UICollectionView alloc]initWithFrame:CGRectZero  collectionViewLayout:layout];
    _collection.showsVerticalScrollIndicator=NO;
    _collection.scrollEnabled=YES;
    
    [_collection registerClass :[ NXPicCollectionViewCell class ] forCellWithReuseIdentifier : @"meizi" ];
    _collection.backgroundColor=[UIColor whiteColor];
    _collection.delegate=self;
    _collection.dataSource=self;
    [self.view addSubview:_collection];
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!_datalist) {
        return 0;
    }
    return [_datalist count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier =@"meizi";
    NXPicCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell=[[NXPicCollectionViewCell alloc]init];
    }
    NSDictionary* dic=[_datalist objectAtIndex:[indexPath row]];
    [cell.PicView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_Url,[dic objectForKey:@"img"]]]];
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2));
    CGFloat twoPiecesWidth = floor(screenWidth / 2.0 - (2.0 / 2));
    
    return CGSizeMake(threePiecesWidth, threePiecesWidth);
    
    
}
//定义每个UICollectionView的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
}



#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
