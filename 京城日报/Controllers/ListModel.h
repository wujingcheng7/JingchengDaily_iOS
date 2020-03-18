//
//  ListModel.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/18.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageName;
@property(nonatomic, copy) NSString *author;
@end

NS_ASSUME_NONNULL_END
