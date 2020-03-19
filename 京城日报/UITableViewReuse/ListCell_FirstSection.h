//
//  ListCell_FirstSection.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ListModel_FirstSection;
@interface ListCell_FirstSection : UITableViewCell
@property (nonatomic, copy) ListModel_FirstSection *model;
-(void)layoutUI;
@end

NS_ASSUME_NONNULL_END
