//
//  ArticlePageController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/17.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ArticlePageController.h"

@interface ArticlePageController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *articleWebView;
@property(nonatomic,strong)UIView *fakeTabBar;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *goodBtn;
@property(nonatomic,strong)UIButton *starBtn;
@property(nonatomic,strong)UIButton *shareBtn;

-(void)hideZhihuBanner;
-(void)createFakeTabBar;
-(void)clickMyButton:(UIButton*)btn;
@end

@implementation ArticlePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化fakeTabBar
    [self createFakeTabBar];
    // Do any additional setup after loading the view.
    
}
-(ArticlePageController *)initWithWebsiteAddress:(NSString *)websiteAddress{//利用站点链接初始化此页面
    if (self = [super init]) {
        CGFloat bigWidth = self.view.frame.size.width;
        CGFloat bigHeight= self.view.frame.size.height;
        //初始化网页内容
        self.articleWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, bigWidth, bigHeight-94)];
        NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:websiteAddress]];
        [self.articleWebView loadRequest:urlRequest];
        self.articleWebView.navigationDelegate = self;
        //wkview 顶部不下拉
        self.articleWebView.scrollView.bounces = NO;
    }
    return self;
}
-(void)hideZhihuBanner{
    NSMutableString *jsString = [NSMutableString string];
    [jsString appendString:@"var x = document.getElementsByClassName('Daily');"];
    [jsString appendString:@"var y = x[0];"];
    [jsString appendString:@"y.style.display='none';"];
    [self.articleWebView evaluateJavaScript:jsString completionHandler:^(id object, NSError * _Nullable error) {
        NSLog(@"\n执行js出错!\nobj:%@\nerror:%@", object, error);
    }];
}
-(void)createFakeTabBar{
    CGFloat dd = (self.view.frame.size.width-80-4*30)/3+30;
    CGFloat height= self.view.frame.size.height-94+10;
    self.view.backgroundColor = [UIColor whiteColor];
    //创建这几个小控件
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, height, 30, 30)];
    _commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(80, height, 30, 30)];
    _goodBtn= [[UIButton alloc]initWithFrame:CGRectMake(80+dd, height, 30, 30)];
    _starBtn = [[UIButton alloc]initWithFrame:CGRectMake(80+dd*2, height, 30, 30)];
    _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(80+dd*3-7, height, 30, 30)];
    UIButton *verticalLine = [[UIButton alloc]initWithFrame:CGRectMake(60, 10, 4, 20)];
    //控件添加图片
    [verticalLine setImage:[UIImage imageNamed:@"verticalLine.png"] forState:UIControlStateNormal];
    [verticalLine setBackgroundColor:[UIColor whiteColor]];
    [_backBtn setImage:[UIImage imageNamed:@"back_black.png"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [_goodBtn setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
    [_starBtn setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    //控件加入fakeTabBar
    [self.view addSubview:_backBtn];
    [self.view addSubview:_commentBtn];
    [self.view addSubview:_goodBtn];
    [self.view addSubview:_starBtn];
    [self.view addSubview:_shareBtn];
    [self.view addSubview:verticalLine];
    //各个控件添加touchupinside事件响应
    [_backBtn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
    [_goodBtn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
    [_starBtn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickMyButton:(UIButton *)btn{
    if (btn == nil) {
        return;
    }else if (btn == self.backBtn){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn == self.commentBtn){
        
    }else if (btn == self.goodBtn){
        
    }else if (btn == self.starBtn){
        
    }else if (btn == self.shareBtn){
        
    }else{
        NSLog(@"clikMyButton方法的点击事件没有编写相应处理方式");
        return;
    }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSMutableString *jsString = [NSMutableString string];
    [jsString appendString:@"var x = document.getElementsByClassName('Daily');"];
    [jsString appendString:@"var y = x[0];"];
    [jsString appendString:@"y.style.display='none';"];
    [self.articleWebView evaluateJavaScript:jsString completionHandler:^(id object, NSError * _Nullable error) {
        NSLog(@"\n执行js情况:obj:%@\nerror:%@", object, error);
    }];
    [NSThread sleepForTimeInterval:0.4];
    //articleWebView均加入view
    [self.view addSubview:self.articleWebView];
}

@end
