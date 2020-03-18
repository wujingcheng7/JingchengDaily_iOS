//
//  ListCell.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/18.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;

@interface ListCell : UITableViewCell
@property(nonatomic, strong) ListModel *model;
@end


