//
//  ListModel_HomePage.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel_HomePage : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *webUrl;
-(ListModel_HomePage*)initWithTitle:(NSString*)title andAuthor:(NSString*)author andImgName:(NSString*)imgName andWebUrl:(NSString*)webUrl;
@end

NS_ASSUME_NONNULL_END
