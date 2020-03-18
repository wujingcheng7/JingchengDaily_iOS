//
//  SettingPageController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/17.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "SettingPageController.h"

@interface SettingPageController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property (strong, nonatomic) UIButton *backBtn;
-(void)gotoOtherPage:(id)something;
@end

@implementation SettingPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景，另外取个常数
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat bigWidth = self.view.frame.size.width;
    CGFloat bigHeight= self.view.frame.size.height;
    //添加tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, bigWidth, bigHeight-104) style:UITableViewStyleGrouped];
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
    if (indexPath.section==0) {
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
            return 2;//第4组2行
    }
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return nil;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    return cell;
}

@end
