//
//  ListModel_FirstSection.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ListModel_FirstSection.h"

@implementation ListModel_FirstSection

-(ListModel_FirstSection *)initWithTitle:(NSString *)title andSubtitle:(NSString * _Nullable)subtitle andWebUrl:(NSString * _Nullable)webUrl{
    if ([self init]) {
        _title = title;
        _subtitle = subtitle;
        _webUrl = webUrl;
    }
    return self;
}
@end
