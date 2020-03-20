//
//  ListCell_HomePage.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ListModel_HomePage;
@interface ListCell_HomePage : UITableViewCell
@property (nonatomic, copy) ListModel_HomePage *model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andModel:(ListModel_HomePage*) model;
@end

NS_ASSUME_NONNULL_END
