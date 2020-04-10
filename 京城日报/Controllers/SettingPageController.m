//
//  SettingPageController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/17.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "SettingPageController.h"
#import "ListModel_FirstSection.h"
#import "ListCell_FirstSection.h"

static NSString *listCellFirstReuseId = @"kListCellFirst";

@interface SettingPageController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property (strong, nonatomic) UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray<ListModel_FirstSection*> *modelArray;

-(void)gotoOtherPage:(id)something;
@end

@implementation SettingPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化modelArray
    self.modelArray = [NSMutableArray array];
    [self initDataOfModelArray];
    //设置背景，另外取个常数
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat bigWidth = self.view.frame.size.width;
    CGFloat bigHeight= self.view.frame.size.height;
    //添加tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, bigWidth, bigHeight-104) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //添加标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, bigWidth, 20)];
    [titleLabel setText:@"设置"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titleLabel];
    //添加返回按钮
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64, 20, 20)];
    [self.view addSubview:_backBtn];
    [_backBtn setImage:[UIImage imageNamed:@"back_black.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(gotoOtherPage:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)gotoOtherPage:(id)something{
    if (something==nil) {
        //do nothing
    }else if (something == self.backBtn){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - tableViewDelegate相关方法⬇️
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置indexPath行的高度,indexPath包含section和row
    if (indexPath.section==0) {//第一行放的是 放大字号
        return 60;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//indexPath所指的元素被点击时的变化
    NSLog(@"第%ld区域第%ld个被点击",indexPath.section,indexPath.row);
    if (indexPath.section == 2 && indexPath.row == 0) {//第三组第1行
        NSString *strUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strUrl]];
    }
//    NSInteger rrow= indexPath.row+3*indexPath.section;
}
#pragma mark - 以下为TableViewDataSourceDelegate相关方法⬇️
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{//返回NSInteger，表示一共有多少section(组)数据
    return 4;//粗暴设置为4组
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//返回NSInteger，表示对应的section(组)有多少row(行)
    switch (section) {
        case 0:
            return 1;//第一组1行
        case 1:
            return 1;//第二组1行
        case 2:
            return 2;//第三组2行
        default:
            return 2;//第四组2行
    }
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return nil;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger i;
    ListCell_FirstSection *cell = [tableView dequeueReusableCellWithIdentifier:listCellFirstReuseId];
    if(cell==nil){
        cell = [[ListCell_FirstSection alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCellFirstReuseId];
        switch (indexPath.section) {
            case 0:
                i=0+indexPath.row;
                break;
            case 1:
                i=1+indexPath.row;
                break;
            case 2:
                i=2+indexPath.row;
                break;
            case 3:
                i=4+indexPath.row;
                break;
            default:
                i=0;
                break;
        }
        cell.model = _modelArray[i];
        [cell layoutUI];
    }
    return cell;
}
-(void)initDataOfModelArray{
    if (_modelArray==nil) {
        NSLog(@"arry为空！");
        return;
    }
    //大字号
    ListModel_FirstSection *model_biggerFont = [[ListModel_FirstSection alloc]initWithTitle:@"大字号" andSubtitle:@"内容页以更大字号显示" andWebUrl:nil];
    [_modelArray addObject:model_biggerFont];
    //清除缓存
    ListModel_FirstSection *model_clearCache = [[ListModel_FirstSection alloc]initWithTitle:@"清除缓存" andSubtitle:nil andWebUrl:nil];
    [_modelArray addObject:model_clearCache];
    //去好评
    ListModel_FirstSection *model_goodVote = [[ListModel_FirstSection alloc]initWithTitle:@"去好评" andSubtitle:nil andWebUrl:@"https://apps.apple.com/us/app/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-%E6%AF%8F%E6%97%A5%E6%8F%90%E4%BE%9B%E9%AB%98%E8%B4%A8%E9%87%8F%E6%96%B0%E9%97%BB%E8%B5%84%E8%AE%AF/id639087967"];
    [_modelArray addObject:model_goodVote];
    //去吐槽
    ListModel_FirstSection *model_feedback = [[ListModel_FirstSection alloc]initWithTitle:@"去吐槽" andSubtitle:nil andWebUrl:@"https://www.zhihu.com/inbox/5582663910"];
    [_modelArray addObject:model_feedback];
    //证照中心
    ListModel_FirstSection *model_licenses = [[ListModel_FirstSection alloc]initWithTitle:@"证照中心" andSubtitle:nil andWebUrl:@"https://zhstatic.zhihu.com/assets/zhihu/publish-license.jpg"];
    [_modelArray addObject:model_licenses];
    //知乎协议
    ListModel_FirstSection *model_protocol = [[ListModel_FirstSection alloc]initWithTitle:@"知乎协议" andSubtitle:nil andWebUrl:@"https://www.zhihu.com/terms"];
    [_modelArray addObject:model_protocol];
    
}
@end
