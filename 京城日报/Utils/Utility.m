//
//  Utility.m
//  京城日报
//
//  Created by 吴京城 on 2020/4/10.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "Utility.h"
CGFloat ScreenWidthPhone;
CGFloat ScreenHeightPhone;
CGFloat SizeShortwidthWithMarginPhone(){
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    ScreenWidthPhone = (screenSize.width<screenSize.height) ? screenSize.width : screenSize.height;
    ScreenHeightPhone = (screenSize.height>screenSize.width) ? screenSize.height : screenSize.width;
    return ScreenWidthPhone;
}
CGFloat getScreenWidthPhone(){
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return MIN(screenSize.width, screenSize.height);
}
CGFloat getScreenHeightPhone(){
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return MAX(screenSize.width, screenSize.height);
}
@implementation Utility

@end
