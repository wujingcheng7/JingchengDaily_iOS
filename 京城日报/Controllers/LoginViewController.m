//
//  LoginViewController.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/16.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>

@interface LoginViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *zhihuBtn;
@property (strong, nonatomic) UIButton *weiboBtn;
@property (strong, nonatomic) UILabel *Title;
@property (strong, nonatomic) UILabel *tint;
@property (strong,nonatomic) UIButton *daynightBtn;
@property (strong,nonatomic) UIButton *settingBtn;
@property (strong,nonatomic) UITextView *protocolText;
-(void)clickedButtonIs:(id)what;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //标题和提示
//    _Title = [[UILabel alloc]initWithFrame:CGRectMake(0, 228, 375, 30)];
//    _tint = [[UILabel alloc]initWithFrame:CGRectMake(0, 267, 375, 21)];
    _Title = [[UILabel alloc]initWithFrame:CGRectZero];
    _tint = [[UILabel alloc]initWithFrame:CGRectZero];
    _Title.text = @"登录京城日报";
    _tint.text = @"选择登录方式";
    _Title.font = [UIFont boldSystemFontOfSize:24];
    _tint.font = [UIFont fontWithName:UIFontTextStyleHeadline size:12];
    _tint.textColor = [UIColor blackColor];
    _Title.textColor = [UIColor blackColor];
    _Title.textAlignment = NSTextAlignmentCenter;
    _tint.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_Title];
    [self.view addSubview:_tint];
    [_Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(228);
        make.height.mas_equalTo(30);
    }];
    [_tint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_Title.mas_bottom).mas_offset(9);
        make.height.mas_equalTo(21);
    }];
    //富文本初始化 可点击
//    _protocolText = [[UITextView alloc]initWithFrame:CGRectMake(50, 368, 325, 24)];
    _protocolText = [[UITextView alloc]initWithFrame:CGRectZero];
    _protocolText.textAlignment = NSTextAlignmentCenter;
    _protocolText.editable = NO;
    _protocolText.scrollEnabled =NO;
    _protocolText.delegate = self;
    NSString* s1=@"注册即代表你同意";
    NSString* s2=@"《知乎协议》";
    NSString* s3=@"和";
    NSString* s4=@"《隐私保护指引》";
    NSString* str=[NSString stringWithFormat:@"%@%@%@%@",s1,s2,s3,s4];
    NSMutableAttributedString *mastring =  [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    NSRange rang2=[str rangeOfString:s2];
    NSRange rang4=[str rangeOfString:s4];
//    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rang1];
//    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:rang2];
//    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang3];
//    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:rang4];
    NSString* valueString2 = [[NSString stringWithFormat:@"a://%@",s2]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString* valueString4 = [[NSString stringWithFormat:@"b://%@",s4]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [mastring addAttribute:NSLinkAttributeName value:valueString2 range:rang2];
    [mastring addAttribute:NSLinkAttributeName value:valueString4 range:rang4];
    _protocolText.attributedText = mastring;
    [self.view addSubview:_protocolText];
    [_protocolText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(368);
        make.height.mas_equalTo(24);
    }];
    //按钮初始化
//    _zhihuBtn = [[UIButton alloc]initWithFrame:CGRectMake(100+15, 308, 50, 50)];
//    _weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(225-15,308, 50, 50)];
    _zhihuBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    _weiboBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64, 20, 20)];
//    _daynightBtn = [[UIButton alloc]initWithFrame:CGRectMake(100-10, 608, 50, 50)];
//    _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(225+10, 608, 50, 50)];
    _daynightBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    _settingBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_zhihuBtn];
    [_zhihuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_centerX).offset(-15);
        make.top.mas_equalTo(self.view.mas_top).offset(308);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.view addSubview:_weiboBtn];
    [_weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_centerX).offset(15);
        make.top.mas_equalTo(_zhihuBtn.mas_top);
        make.size.mas_equalTo(_zhihuBtn);
    }];
    [self.view addSubview:_backBtn];
    [self.view addSubview:_daynightBtn];
    [_daynightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_centerX).offset(-30);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-200);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.view addSubview:_settingBtn];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_centerX).offset(30);
        make.bottom.mas_equalTo(_daynightBtn.mas_bottom);
        make.size.mas_equalTo(_daynightBtn);
    }];
    [_zhihuBtn setImage:[UIImage imageNamed:@"zhihu.png"] forState:UIControlStateNormal];
    [_zhihuBtn addTarget:self action:@selector(clickedButtonIs:) forControlEvents:UIControlEventTouchUpInside];
    [_weiboBtn setImage:[UIImage imageNamed:@"weibo.png"] forState:UIControlStateNormal];
    _weiboBtn.backgroundColor = [UIColor whiteColor];
    _weiboBtn.layer.cornerRadius = 25;
    _weiboBtn.layer.masksToBounds =YES;
    [_weiboBtn addTarget:self action:@selector(clickedButtonIs:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setImage:[UIImage imageNamed:@"back_black.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(clickedButtonIs:) forControlEvents:UIControlEventTouchUpInside];
    [_daynightBtn setImage:[UIImage imageNamed:@"moon.png"] forState:UIControlStateNormal];//默认月亮
    [_daynightBtn addTarget:self action:@selector(clickedButtonIs:) forControlEvents: UIControlEventTouchUpInside];
    [_settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(clickedButtonIs:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        UIColor *color = (self.daynightBtn.tag==0)?[UIColor whiteColor]:[UIColor darkGrayColor];
        return color;
    }];
}
-(void)clickedButtonIs:(id)what{
    if (what == _backBtn) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if ([what isKindOfClass:[NSString class]]){//如果是字符串
        if ([what isEqualToString:@"知乎协议"]) {
            WebsitePageController* p = [[WebsitePageController alloc]initWithWebSiteAddress:@"https://www.zhihu.com/terms" andTitle:@"知乎协议"];
            [self.navigationController pushViewController:p animated:YES];
        }else if ([what isEqualToString:@"隐私保护指引"]){
            WebsitePageController* p = [[WebsitePageController alloc]initWithWebSiteAddress:@"https://www.zhihu.com/term/privacy" andTitle:@"隐私保护指引"];
            [self.navigationController pushViewController:p animated:YES];
        }else{
            NSLog(@"富文本跳转写的有问题");
        }
    }
    else if (what == _zhihuBtn){
        WebsitePageController* p = [[WebsitePageController alloc]initWithWebSiteAddress:@"https://www.zhihu.com/signin" andTitle:@"登录知乎"];
        [self.navigationController pushViewController:p animated:YES];
    }else if (what == _weiboBtn){
        WebsitePageController* p = [[WebsitePageController alloc]initWithWebSiteAddress:@"https://passport.weibo.cn/signin/login" andTitle:@"登录微博"];
        [self.navigationController pushViewController:p animated:YES];
    }else if (what == _daynightBtn){
        if (_daynightBtn.tag) {//若为1则代表已经是黑暗模式，下面转化为白天模式
            [_daynightBtn setImage:[UIImage imageNamed:@"moon.png"] forState:UIControlStateNormal];
            [_daynightBtn setTag:0];
            self.view.backgroundColor = [UIColor whiteColor];
            self.protocolText.backgroundColor = [UIColor whiteColor];
        }else{//若为0则代表已经是白天模式，下面转化为黑暗模式
            [_daynightBtn setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
            [_daynightBtn setTag:1];
            self.view.backgroundColor = [UIColor darkGrayColor];
            self.protocolText.backgroundColor = [UIColor darkGrayColor];
        }
    }else if (what == _settingBtn){
        SettingPageController *p = [[SettingPageController alloc]init];
        [self.navigationController pushViewController:p animated:YES];
    }else{
        NSLog(@"LoginViewController的clickedButtonIs方法待完善！");
    }
}
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSString* what = [[URL scheme]isEqualToString:@"a"]?@"知乎协议":@"隐私保护指引";
    [self clickedButtonIs:what];
    return NO;
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
