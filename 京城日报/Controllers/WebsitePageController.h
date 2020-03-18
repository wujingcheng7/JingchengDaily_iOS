//
//  WebsitePageController.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/17.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WebsitePageController : UIViewController
-(WebsitePageController*)initWithWebSiteAddress:(NSString*)websiteAddress andTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
