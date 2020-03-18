//
//  WebsitePageController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/17.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "WebsitePageController.h"

@interface WebsitePageController ()
@property(nonatomic,strong)WKWebView *articleWebView;
@property (strong, nonatomic) UIButton *backBtn;
-(void)gotoOtherPage:(id)what;
@end

@implementation WebsitePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64, 20, 20)];
    [self.view addSubview:_backBtn];
     [_backBtn setImage:[UIImage imageNamed:@"back_black.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(gotoOtherPage:) forControlEvents:UIControlEventTouchUpInside];
}
-(WebsitePageController *)initWithWebSiteAddress:(NSString *)websiteAddress andTitle:(nonnull NSString *)title{
    if(self=[super init]){
        CGFloat bigWidth = self.view.frame.size.width;
        CGFloat bigHeight= self.view.frame.size.height;
        //初始化网页内容
        self.articleWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 94, bigWidth, bigHeight-94)];
        NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:websiteAddress]];
        [self.articleWebView loadRequest:urlRequest];
        [self.view addSubview:self.articleWebView];
        //添加标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, bigWidth, 20)];
        [titleLabel setText:title];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.view addSubview:titleLabel];
    }
    return self;
}

-(void)gotoOtherPage:(id)what{
    if (what == _backBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    }
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
