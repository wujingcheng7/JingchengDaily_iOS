//
//  ListModel_HomePage.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ListModel_HomePage.h"

@implementation ListModel_HomePage
-(ListModel_HomePage *)initWithTitle:(NSString *)title andAuthor:(NSString *)author andImgName:(NSString *)imgName andWebUrl:(NSString *)webUrl{
    if ([self init]) {
        _title = title;
        _author = author;
        _imgName = imgName;
        _webUrl = webUrl;
    }
    return self;
}
@end
