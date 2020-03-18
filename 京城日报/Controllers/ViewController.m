//
//  ViewController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/16.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ViewController.h"
#import "ListCell.h"
#import "ListModel.h"


static NSString *listCellReuseId = @"kListCell";
//OC的 category 和 extension
@interface ViewController ()

@property (nonatomic, strong) UIButton *userImageButton;
@property (nonatomic, strong) UIScrollView *thisScrollView;
@property (nonatomic, strong) UITableView *thisTableView;
@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, copy) NSArray *sclViewTitles;
@property (nonatomic, strong) NSArray *sclViewWebUrls;
@property (nonatomic, strong) NSMutableArray<UIButton*> *sclViewBtns;
@property (nonatomic, copy) NSArray *tabViewTitles;
@property (nonatomic, copy) NSArray *tabViewAuthors;
@property (nonatomic, copy) NSArray *tabViewWebUrls;
    //TODO: 这里准备做替换
//@property (nonatomic, strong) NSMutableArray *dataArray;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;//隐藏navigationBar
        //TODO: 这里准备做替换
//    self.dataArray = [NSMutableArray array];
    [self initSomeTmpData];//init展示需要的数据
    [self initThisTableView];//init TableView (包含ScrollView)
    [self initToolbar];
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
    NSInteger rrow= indexPath.row+3*indexPath.section;
    ArticlePageController *APC_ptr = [[ArticlePageController alloc]initWithWebsiteAddress:self.tabViewWebUrls[rrow]];
    [self.navigationController pushViewController:APC_ptr animated:YES];
}
#pragma mark - 此方法既控制thisTableView也控制thisScrollView⬇️
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.thisScrollView) {//如果thisScrollView调用
            CGFloat offsetX = scrollView.contentOffset.x;
            if (((NSInteger)offsetX)%375 == 0) {//横向移动
                NSInteger number = (NSInteger)(offsetX/375);
                NSLog(@"当前scrollview到了第%ld个子元素(从0计数)",number);
            }
    }else if (scrollView == self.thisTableView){//如果thisTableView调用
        UITableView* tableview = (UITableView*)scrollView;
        UIScrollView* scV =self.thisScrollView;//获取横向滚动scrollview
        CGFloat offsetY = tableview.contentOffset.y;//tableview的offset y
        CGFloat bigWidth = tableview.frame.size.width;//tableview的X长度
        CGFloat offsetX = scV.contentOffset.x;//scrollview 的offset x
        NSInteger i = (NSInteger)(offsetX)/(NSInteger)(bigWidth);// scrollview 的图片序号，从0开始
        UIImageView* imgView = scV.subviews[i].subviews[0];//scrollview的图片
        CGPoint center = imgView.center;
        if (offsetY<0) {
            CGFloat scale = (bigWidth-offsetY)/bigWidth;
            imgView.transform = CGAffineTransformMakeScale(scale, scale);
            imgView.center = center;
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
    return 3;//粗暴设置为3组
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//返回NSInteger，表示对应的section(组)有多少row(行)
    return 3;//粗暴设置为3个组都是3行
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //假装给section设置了时间
    if (section==0)return @" 今 天";
    NSString* result = [NSString stringWithFormat:@" %ld 月 %ld 日",[self nowTimeMonthInt],[self nowTimeDay]-section];
    return result;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//返回TableViewCell对象，即每一行的数据

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSInteger rrow= indexPath.row+3*indexPath.section;
    cell.textLabel.text = self.tabViewTitles[rrow];//设置标题
    cell.detailTextLabel.text = [NSString stringWithFormat:@"作者/%@",self.tabViewAuthors[rrow]];//设置作者
    //设置右侧图片
    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"tab-%ld.jpg",rrow]];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 66, 66);
    cell.accessoryView = imgView;
    //返回UITableViewCell对象
    
    //TODO: 这里准备做替换
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellReuseId];
//    cell.model = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - 初始化时的一些方法⬇️
-(void)initThisTableView{
    /*
     创建TableView
     */
    UITableView* tableViewPtr= [[UITableView alloc]initWithFrame:CGRectMake(0,106,self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStyleGrouped];
//    [tableViewPtr mas_remakeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//    }];
    self.thisTableView = tableViewPtr;
    self.thisTableView.delegate = self;
    self.thisTableView.dataSource = self;
    [self.view addSubview:self.thisTableView];
    
    [tableViewPtr registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableViewPtr registerClass:[ListCell class] forCellReuseIdentifier:listCellReuseId];
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
        [self addImageViewForThisScrollViewWithImage:[NSString stringWithFormat:@"scroll_%d.jpg",i] withNumber:i withTitle:self.sclViewTitles[i]];
    }
    /*
     ScrollView成为TableView的TableHeaderView  TableView加入self.view
     */
    [self.thisTableView setTableHeaderView:self.thisScrollView];

}
-(void)addImageViewForThisScrollViewWithImage:(NSString *)imageName withNumber:(NSInteger)number withTitle:(NSString *)title{
    CGFloat widthAndHeight = self.view.bounds.size.width;
    //添加一个架子，用于安装图片按钮和标题
    UIView* view = [[UIView alloc]initWithFrame:CGRectOffset(self.thisScrollView.bounds, widthAndHeight*number, 0)];
    //添加图片按钮
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthAndHeight, widthAndHeight+0)];//
//    imageView.bounds = CGRectMake(0, 0, widthAndHeight, widthAndHeight);//
//    UIImage* image = [UIImage imageNamed:imageName];
//    [imageView setImage:image];
//    [view addSubview:imageView];
//    imageView.center = CGPointMake(widthAndHeight/2, 0+(widthAndHeight/2));
    //添加图片按钮并且绑定事件
    if (self.sclViewBtns == nil ) {
        self.sclViewBtns = [NSMutableArray arrayWithCapacity:5];
    }
    UIButton* btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, widthAndHeight, widthAndHeight)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(gotoArticleBy:) forControlEvents:UIControlEventTouchUpInside];
    self.sclViewBtns[number] =btn;
    
    //添加标题,与图片绑定
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 300+0, widthAndHeight, 40)];
    label.text = title;
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
//    ListModel *model = [[ListModel alloc] init];
//    model.title = @"";
//    model.imageName = @"";
//    model.author = @"";
//    [self.dataArray addObject:model];
    
    self.tabViewTitles  =@[@"如果「生化危机」发生在中国，我该怎么逃生？",@"「创造力」是可以后天习得的吗？",@"斯里兰卡为什么不属于英属印度？",@"为什么美国 CDC 不建议戴口罩预防新冠肺炎？",@"人类语言各不相通，历史上第一个翻译是如何做到的？",@"红绿灯是怎么被发明出来的？",@"《红楼梦》有什么缺点或者不足？",@"宠物会察觉到人类的悲伤情绪吗？",@"如何看待同人作品的法律风险？"];
    self.tabViewAuthors
    =@[@"小刀不磨",@"贝塔",@"何赟",@"司马懿",@"zeno",@"穆卡",@"invalid s",@"王福瑞",@"一丁"];
    self.sclViewTitles
    =@[@"西方国家为什么不用瑞德西韦治疗新冠病毒患者？",@"瞎扯 · 如何正确地吐槽",@"饶毅：英国首相的「群体免疫」谎言",@"古装丧尸韩剧《王国》第二季中有哪些细思极恐的细节？",@"苹果产品中的哪些细节让你突然有感动的感觉？"];
    self.sclViewWebUrls
    =@[@"https://daily.zhihu.com/story/9721598",@"https://daily.zhihu.com/story/9721444",@"https://daily.zhihu.com/story/9721701",@"https://daily.zhihu.com/story/9721695",@"https://daily.zhihu.com/story/9721681"];
    self.tabViewWebUrls
    =@[@"https://daily.zhihu.com/story/9721181",@"https://daily.zhihu.com/story/9721174",@"https://daily.zhihu.com/story/9721045",@"https://daily.zhihu.com/story/9721110",@"https://daily.zhihu.com/story/9721029",@"https://daily.zhihu.com/story/9721100",@"https://daily.zhihu.com/story/9721063",@"https://daily.zhihu.com/story/9721053",@"https://daily.zhihu.com/story/9721127"];
        //TODO: 这里准备做替换
//    self.sclViewBtns = [NSMutableArray arrayWithCapacity:5];
}
-(void)gotoLoginPage:(id)item{
    if(item == self.userImageButton){
        NSLog(@"点击了头像！");
        LoginViewController *lg = [[LoginViewController alloc]init];
//        lg.modalPresentationStyle = UIModalPresentationPopover;
//        lg.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
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
    //创建toolbar
//    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 44, 375, 60)];
//    self.toolbar.barStyle = UIBarStyleDefault;
//    self.toolbar.backgroundColor = [UIColor systemBackgroundColor];
//    [self.toolbar setShadowImage:nil forToolbarPosition:UIBarPositionTop];
    self.toolbar = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 375, 60)];
    [self.view addSubview:self.toolbar];
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
@end

