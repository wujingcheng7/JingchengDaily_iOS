//
//  ViewController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/16.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ViewController.h"
#import "ListCell_HomePage.h"
#import "ListModel_HomePage.h"
#import <Masonry/Masonry.h>
#import "Utility.h"
static NSString *listCellReuseId = @"kListCell_HomePage";
//OC的 category 和 extension
@interface ViewController ()

@property (nonatomic, strong) UIButton *userImageButton;
@property (nonatomic, strong) UIScrollView *thisScrollView;
@property (nonatomic, strong) UITableView *thisTableView;
@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, copy) NSArray *sclViewTitles;
@property (nonatomic, copy) NSArray *sclViewWebUrls;
@property (nonatomic, strong) NSMutableArray<UIButton*> *sclViewBtns;
@property (nonatomic, copy) NSArray *tabViewTitles;
@property (nonatomic, copy) NSArray *tabViewAuthors;
@property (nonatomic, copy) NSArray *tabViewWebUrls;
@property (nonatomic, strong) UIImageView *cheatingImgView;//用于视觉欺骗的图片
@property (nonatomic, strong) UILabel *cheatingLabelView;//用于视觉欺骗的文字
@property (nonatomic, strong) NSMutableArray *dataTableCellArray;//tableView动态数组(暂时不包含header内scrollview)






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"--获取到以下数据:\n----屏幕宽度：%lf\n----屏幕高度：%lf\n",Wujingcheng7_iPhoneScreenWidth,Wujingcheng7_iPhoneScreenHeight);
    self.navigationController.navigationBar.hidden = YES;//隐藏navigationBar
        //TODO: 这里准备做替换
    [self initSomeTmpData];//init展示需要的数据
    [self initThisTableView];//init TableView (包含ScrollView)
    [self initToolbar];
    [self initCheatingThings];//欺骗性内容，用于图片拉伸
}
#pragma mark - tableViewDelegate相关方法⬇️
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置indexPath行的高度,indexPath包含section和row
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//indexPath所指的元素被点击时的变化
    NSLog(@"第%ld区域第%ld个被点击",indexPath.section,indexPath.row);
    ListCell_HomePage* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* webUrl = cell.model.webUrl;
    ArticlePageController *APC_ptr = [[ArticlePageController alloc]initWithWebsiteAddress:webUrl];
    [self.navigationController pushViewController:APC_ptr animated:YES];
}
#pragma mark - 此方法既控制thisTableView也控制thisScrollView⬇️
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.thisScrollView) {//如果thisScrollView调用
//            CGFloat offsetX = scrollView.contentOffset.x;
//            if (((NSInteger)offsetX)%375 == 0) {//横向移动
//                NSInteger number = (NSInteger)(offsetX/375);
//                NSLog(@"当前scrollview到了第%ld个子元素(从0计数)",number);
//            }
    }else if (scrollView == self.thisTableView){//如果thisTableView调用
        UITableView* tableview = (UITableView*)scrollView;
        UIScrollView* scV =self.thisScrollView;//获取横向滚动scrollview
        CGFloat offsetY = tableview.contentOffset.y;//tableview的offset y
        CGFloat bigWidth = tableview.frame.size.width;//tableview的X长度
        CGFloat offsetX = scV.contentOffset.x;//scrollview 的offset x
        NSInteger i = (NSInteger)(offsetX)/(NSInteger)(bigWidth);// scrollview 的图片序号，从0开始
        if (offsetY<0) {
            self.cheatingImgView.frame = CGRectMake(0+offsetY/2,106,bigWidth-offsetY,bigWidth-offsetY);
            ListModel_HomePage* tmpModel = _dataTableCellArray[i];
            if(self.cheatingImgView.tag){
                [self.cheatingImgView setImage:[UIImage imageNamed:tmpModel.imgName]];
                self.cheatingImgView.tag = 0;
            }
            self.cheatingLabelView.frame = CGRectMake(20, 406-offsetY, bigWidth, 70);
            if (self.cheatingLabelView.tag) {
//                self.cheatingLabelView.text = self.sclViewTitles[i];
                self.cheatingLabelView.text = tmpModel.title;
                self.cheatingLabelView.tag = 0;
            }
        }else{//offsetY>=0
            [self.cheatingImgView setImage:nil];
            self.cheatingImgView.frame = CGRectMake(0, 0, 0, 0 );
            self.cheatingLabelView.frame = CGRectMake(0, 0, 0, 0);
            self.cheatingImgView.tag = 1;
            self.cheatingLabelView.tag =1;
        }
    }
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(scrollView == self.thisScrollView){//如果thisScrollview调用
        NSArray<UIImageView*>* subviews = scrollView.subviews;
        CGFloat numberFloat = scrollView.contentOffset.x*5/scrollView.frame.size.width;
        NSInteger numberInt = (NSInteger) numberFloat;
        return subviews[numberInt].subviews[0];//返回要改变的view
    }else{
        return nil;
    }
}

#pragma mark - 以下为TableViewDataSourceDelegate相关方法⬇️
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{//返回NSInteger，表示一共有多少section(组)数据
    NSInteger count = _dataTableCellArray.count - 5;
    NSInteger n = count/3;
    return (count%3)? (n+1): n;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//返回NSInteger，表示对应的section(组)有多少row(行)
    NSInteger sectionMax = [self numberOfSectionsInTableView:tableView] - 1;//获取section最大值=section总数-1
    if (section<sectionMax) {//非最后一行
        return 3;
    }else{//最后一行
        NSInteger count = _dataTableCellArray.count - 5;
        return (count%3)? (count%3): 3;
    }
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //假装给section设置了时间
    if (section==0)return @" 今 天";
    NSString* result = [NSString stringWithFormat:@" %ld 月 %ld 日",[self nowTimeMonthInt],[self nowTimeDay]-section];
    return result;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//返回TableViewCell对象，即每一行的数据
    NSInteger Number = indexPath.section*3 + indexPath.row;
    NSInteger count = _dataTableCellArray.count -5;
    ListCell_HomePage *cell = [tableView dequeueReusableCellWithIdentifier:listCellReuseId];
    if (Number<count && cell==nil) {//没有cell了但是却有数据可以制作cell
        //制作cell
        cell = [[ListCell_HomePage alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCellReuseId andModel:_dataTableCellArray[Number+5]];
//        NSLog(@"第%ld号cell的内容，title=%@,imgName=%@.\n",Number,cell.model.title,cell.model.imgName);
    }
    return cell;
}
#pragma mark - 初始化时的一些方法⬇️
-(void)initThisTableView{
    /*
     创建Scrollview
     */
    CGFloat widthAndHeight = self.view.bounds.size.width;
    self.thisScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, widthAndHeight, widthAndHeight)];//
    self.thisScrollView.contentSize=CGSizeMake(widthAndHeight*5, widthAndHeight);//++0+
    self.thisScrollView.showsHorizontalScrollIndicator = NO;
    self.thisScrollView.showsVerticalScrollIndicator = NO;
    //控制缩放
    self.thisScrollView.maximumZoomScale = (CGFloat)3;
    self.thisScrollView.minimumZoomScale = (CGFloat)1;
    //允许scrollview被点击
    self.thisScrollView.userInteractionEnabled = YES;
    //可翻页，设置代理
    self.thisScrollView.pagingEnabled = YES;
    self.thisScrollView.delegate = self;
    //添加5个轮播内容，图片+标题
    for (int i=0; i<5; i++) {//添加5个图片
        ListModel_HomePage *tmpData = _dataTableCellArray[i];
        [self addImageViewForThisScrollViewWithImage:tmpData.imgName withNumber:i withTitle:tmpData.title];
    }
    /*
     创建TableView
     */
    UITableView* tableViewPtr= [[UITableView alloc]initWithFrame:CGRectMake(0,106,self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    self.thisTableView = tableViewPtr;
    [self.thisTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.thisTableView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor blackColor];
        }else{
            return [UIColor whiteColor];
        }
    }];
    self.thisTableView.showsVerticalScrollIndicator = NO;
//    [tableViewPtr registerClass:[ListCell_HomePage class] forCellReuseIdentifier:listCellReuseId];
    self.thisTableView.delegate = self;
    self.thisTableView.dataSource = self;
    [self.view addSubview:self.thisTableView];
    /*
     ScrollView成为TableView的TableHeaderView  TableView加入self.view
     */
    [self.thisTableView setTableHeaderView:self.thisScrollView];

}
-(void)addImageViewForThisScrollViewWithImage:(NSString *)imageName withNumber:(NSInteger)number withTitle:(NSString *)title{
    CGFloat widthAndHeight = self.view.bounds.size.width;
    //添加一个架子，用于安装图片按钮和标题
    UIView* view = [[UIView alloc]initWithFrame:CGRectOffset(self.thisScrollView.bounds, widthAndHeight*number, 0)];
    //添加图片按钮并且绑定事件
    if (self.sclViewBtns == nil ) {
        self.sclViewBtns = [NSMutableArray arrayWithCapacity:5];
    }
    UIButton* btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, widthAndHeight, widthAndHeight)];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(gotoArticleBy:) forControlEvents:UIControlEventTouchUpInside];
    self.sclViewBtns[number] =btn;
    
    //添加标题,与图片绑定
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 300+0, widthAndHeight, 70)];
    label.text = title;
    label.numberOfLines = 2;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Courier New" size:18.0f];
    [view addSubview:label];
    [self.thisScrollView addSubview:view];
}

#pragma mark - 获取时间（月日小时）的4个方法⬇️
-(NSInteger)nowTimeHour{//获取几点
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDate* dateNow = [NSDate date];
    NSString* currentHour = [formatter stringFromDate:dateNow];
    return currentHour.intValue;
}
-(NSInteger)nowTimeDay{//获取 日
    NSDateFormatter *formatterDay = [[NSDateFormatter alloc]init];
    NSDate* dateNow = [NSDate date];
    [formatterDay setDateFormat:@"dd"];
    NSString* currentDay = [formatterDay stringFromDate:dateNow];
    return currentDay.intValue;
}
-(NSInteger)nowTimeMonthInt{//获取 月，NSInteger
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc]init];
    [formatterMonth setDateFormat:@"MM"];
    NSDate* dateNow = [NSDate date];
    NSString* currentMonth = [formatterMonth stringFromDate:dateNow];
    return currentMonth.intValue;
}
-(NSString*)nowTimeMonthString{//获取 月,字符串
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc]init];
    [formatterMonth setDateFormat:@"MM"];
    NSDate* dateNow = [NSDate date];
    NSString* currentMonth = [formatterMonth stringFromDate:dateNow];
    NSString* month[12]={@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"};
    return month[currentMonth.intValue-1];
}
-(void)initSomeTmpData{
        //TODO: 这里准备做替换
    _dataTableCellArray = [NSMutableArray array];//TODO: 如何复用呢？这是个问题
    ListModel_HomePage *model_0 = [[ListModel_HomePage alloc]initWithTitle:@"西方国家为什么不用瑞德西韦治疗新冠病毒患者？" andAuthor:@"菲利普医生" andImgName:@"scroll_0.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721598"];
    ListModel_HomePage *model_1 = [[ListModel_HomePage alloc]initWithTitle:@"瞎扯 · 如何正确地吐槽" andAuthor:@"知乎用户" andImgName:@"scroll_1.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721444"];
    ListModel_HomePage *model_2 = [[ListModel_HomePage alloc]initWithTitle:@"饶毅：英国首相的「群体免疫」谎言" andAuthor:@"知识分子" andImgName:@"scroll_2.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721701"];
    ListModel_HomePage *model_3 = [[ListModel_HomePage alloc]initWithTitle:@"古装丧尸韩剧《王国》第二季中有哪些细思极恐的细节？" andAuthor:@"首阳大君" andImgName:@"scroll_3.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721695"];
    ListModel_HomePage *model_4 = [[ListModel_HomePage alloc]initWithTitle: @"苹果产品中的哪些细节让你突然有感动的感觉？"andAuthor:@"知乎用户" andImgName:@"scroll_4.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721681"];
    [_dataTableCellArray addObject:model_0];
    [_dataTableCellArray addObject:model_1];
    [_dataTableCellArray addObject:model_2];
    [_dataTableCellArray addObject:model_3];
    [_dataTableCellArray addObject:model_4];
    ListModel_HomePage *model_5 = [[ListModel_HomePage alloc]initWithTitle:@"如果「生化危机」发生在中国，我该怎么逃生？" andAuthor:@"小刀不磨" andImgName:@"tab-0.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721181"];
    ListModel_HomePage *model_6 = [[ListModel_HomePage alloc]initWithTitle:@"「创造力」是可以后天习得的吗？" andAuthor:@"贝塔" andImgName:@"tab-1.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721174"];
    ListModel_HomePage *model_7 = [[ListModel_HomePage alloc]initWithTitle:@"斯里兰卡为什么不属于英属印度？" andAuthor:@"何赟" andImgName:@"tab-2.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721045"];
    ListModel_HomePage *model_8 = [[ListModel_HomePage alloc]initWithTitle:@"为什么美国 CDC 不建议戴口罩预防新冠肺炎？" andAuthor:@"司马懿" andImgName:@"tab-3.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721110"];
    ListModel_HomePage *model_9 = [[ListModel_HomePage alloc]initWithTitle:@"人类语言各不相通，历史上第一个翻译是如何做到的？" andAuthor:@"zeno" andImgName:@"tab-4.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721029"];
    ListModel_HomePage *model_10 = [[ListModel_HomePage alloc]initWithTitle:@"红绿灯是怎么被发明出来的？" andAuthor:@"穆卡" andImgName:@"tab-5.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721100"];
    ListModel_HomePage *model_11 = [[ListModel_HomePage alloc]initWithTitle:@"《红楼梦》有什么缺点或者不足？" andAuthor:@"invalid s" andImgName:@"tab-6.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721063"];
    ListModel_HomePage *model_12 = [[ListModel_HomePage alloc]initWithTitle:@"宠物会察觉到人类的悲伤情绪吗？" andAuthor:@"王福瑞" andImgName:@"tab-7.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721053"];
    ListModel_HomePage *model_13 = [[ListModel_HomePage alloc]initWithTitle:@"如何看待同人作品的法律风险？" andAuthor:@"一丁" andImgName:@"tab-8.jpg" andWebUrl:@"https://daily.zhihu.com/story/9721127"];
    [_dataTableCellArray addObject:model_5];
    [_dataTableCellArray addObject:model_6];
    [_dataTableCellArray addObject:model_7];
    [_dataTableCellArray addObject:model_8];
    [_dataTableCellArray addObject:model_9];
    [_dataTableCellArray addObject:model_10];
    [_dataTableCellArray addObject:model_11];
    [_dataTableCellArray addObject:model_12];
    [_dataTableCellArray addObject:model_13];
   
}
-(void)gotoLoginPage:(id)item{
    if(item == self.userImageButton){
        NSLog(@"点击了头像！");
        LoginViewController *lg = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lg animated:YES];
    }
}
-(void)gotoArticleBy:(UIButton *)button{
    CGFloat offsetX = self.thisScrollView.contentOffset.x;
    NSInteger number = (NSInteger)(offsetX/375);//目前横向的滚动图到了第number个图（从0开始）
    ArticlePageController *APC_ptr = [[ArticlePageController alloc]initWithWebsiteAddress:self.sclViewWebUrls[number]];
    [self.navigationController pushViewController:APC_ptr animated:YES];
    
}
#pragma mark - Toolbar初始化方法⬇️
-(void)initToolbar{//创建toolbar并添加元素
//    self.toolbar = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 375, 60)];
    self.toolbar = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.toolbar];
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(44);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(60);
    }];
    //添加时间label，并适配黑暗模式
    UILabel* labelTimeDay = [[UILabel alloc]initWithFrame:CGRectMake(14, 6, 40, 24)];
    UILabel* labelTimeMon = [[UILabel alloc]initWithFrame:CGRectMake(14, 24, 40, 36)];
    labelTimeDay.text = [NSString stringWithFormat:@" %ld",[self nowTimeDay]];
    labelTimeMon.text = [NSString stringWithFormat:@"%@月",[self nowTimeMonthString]];
    labelTimeDay.textColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor whiteColor];
        } else {
            return [UIColor blackColor];}}];
    labelTimeMon.textColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
    if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];}}];
    labelTimeDay.font = [UIFont boldSystemFontOfSize:24.0f];
    labelTimeMon.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.toolbar addSubview:labelTimeDay];
    [self.toolbar addSubview:labelTimeMon];
    //添加隔断ImageView
    UIImageView* verticalLine = [[UIImageView alloc]initWithFrame:CGRectMake(60, 5, 2, 50)];
    UIImage* imageLine = [UIImage imageNamed:@"verticalLine.png"];
    [verticalLine setImage:imageLine];
    verticalLine.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
    if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];}}];
    [self.toolbar addSubview:verticalLine];
    //添加标题Label，正常显示“京城日报”，晚间显示“早点休息”，并适配黑暗模式
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 7, 120, 48)];
    labelTitle.textColor =[UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
    if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];}}];
    labelTitle.numberOfLines=1;
    labelTitle.font = [UIFont boldSystemFontOfSize:26.0f];
    NSInteger nowHour = [self nowTimeHour];
    if (nowHour<6||nowHour>22) {
        labelTitle.text=@"早点休息";
    }else if(nowHour>=6 &&nowHour<=9){
        labelTitle.text=@"早上好！";
    }else{
        labelTitle.text=@"京城日报";
    }
    [self.toolbar addSubview:labelTitle];
    //添加头像，默认为刘看山
    self.userImageButton = [[UIButton alloc]initWithFrame:CGRectMake(325, 10, 40, 40)];
    UIImage* imageDefaultUser = [UIImage imageNamed:@"liukanshan_circle.png"];
    [self.userImageButton setImage:imageDefaultUser forState:UIControlStateNormal];
    [self.toolbar addSubview:self.userImageButton];
    //头像添加点击事件
    [self.userImageButton addTarget:self action:@selector(gotoLoginPage:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initCheatingThings{
    self.cheatingLabelView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.cheatingImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.cheatingLabelView.font = [UIFont fontWithName:@"Courier New" size:18.0f];;
    self.cheatingLabelView.textColor = [UIColor whiteColor];
    self.cheatingLabelView.numberOfLines = 2;
    self.cheatingImgView.tag = 1;
    self.cheatingImgView.tag = 1;
    [self.view addSubview:self.cheatingImgView];
    [self.view addSubview:self.cheatingLabelView];
}
@end

