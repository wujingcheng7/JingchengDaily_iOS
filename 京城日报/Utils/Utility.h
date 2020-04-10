//
//  Utility.h
//  京城日报
//
//  Created by 吴京城 on 2020/4/10.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern CGFloat ScreenWidthPhone;
extern CGFloat ScreenHeightPhone;

CGFloat SizeShortwidthWithMarginPhone(void);
CGFloat getScreenWidthPhone(void);
CGFloat getScreenHeightPhone(void);

#define UISizeScale_iPhone(k) (getScreenWidthPhone()/1024*k)
#define Wujingcheng7_iPhoneScreenWidth getScreenWidthPhone()
#define Wujingcheng7_iPhoneScreenHeight getScreenHeightPhone()


@interface Utility : NSObject

@end

