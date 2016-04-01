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
#import "MSSBrowseDefine.h"
#import "KTDropdownMenuView.h"
@interface NXPicViewController (){
    int pageindex;
    BOOL isloading;
    int ID;
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
    ID=1;
    _collection.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [_collection.mj_header beginRefreshing];
    _collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    NSArray *titles = @[@"性感美女", @"日韩美女", @"丝袜美腿", @"美女照片", @"美女写真",@"青春美女",@"性感车模"];
    KTDropdownMenuView *menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    menuView.width = 150;
    menuView.cellColor=[UIColor whiteColor];
    menuView.textColor=[UIColor blackColor];
    self.navigationItem.titleView = menuView;
    menuView.selectedAtIndex = ^(int index)
    {
        NSLog(@"selected title:%@", titles[index]);
        ID=index+1;
        [_collection.mj_header beginRefreshing];
    };
    
}
-(void)getData{
    isloading=true;
    pageindex=1;
    [Net GetImageUrs:pageindex id:ID  success:^(id response) {
        NSLog(@"%@",response);
        [_datalist removeAllObjects];
        NSArray* data=[response objectForKey:@"tngou"];
        if (data) {
            for (int i=0; i<[data count]; i++) {
                [_datalist addObject:data[i]];
            }
        }
        
        [_collection.mj_header endRefreshing];
        [_collection reloadData];
        NSLog(@"%zd datalist count",[_datalist count]);
        isloading=false;
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [_collection.mj_header endRefreshing];
        isloading=false;
        [_collection reloadData];
    }];
}
-(void)loadMoreData{
    pageindex++;
    isloading=true;
    [Net GetImageUrs:pageindex id:ID  success:^(id response) {
        
        NSArray* data=[response objectForKey:@"tngou"];
        if (data) {
            for (int i=0; i<[data count]; i++) {
                [_datalist addObject:data[i]];
            }
        }
        NSLog(@"%zd datalist count",[_datalist count]);
        [_collection reloadData];
        [_collection.mj_footer endRefreshing];
        isloading=false;
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [_collection.mj_footer endRefreshing];
        isloading=false;
        [_collection reloadData];
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
    NXPicCollectionViewCell *cell = (NXPicCollectionViewCell *)[_collection cellForItemAtIndexPath:indexPath];
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    
    for(int i = 0;i < [_datalist count];i++)
    {
        NSDictionary* dic=[_datalist objectAtIndex:i];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = [NSString stringWithFormat:@"%@%@",PIC_Url,[dic objectForKey:@"img"]];// 大图url地址
        browseItem.smallImageView = cell.PicView;
        [browseItemArray addObject:browseItem];
    }
    
    
    MSSBrowseViewController *bvc = [[MSSBrowseViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:[indexPath row]];
    [bvc showBrowseViewController];
}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{if(!isloading){
    return YES;
}
    return NO;
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
