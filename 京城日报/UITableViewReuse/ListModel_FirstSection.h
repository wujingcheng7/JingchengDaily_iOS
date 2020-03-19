//
//  ListModel_FirstSection.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel_FirstSection : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString * _Nullable subtitle;
@property (nonatomic, copy) NSString * _Nullable webUrl;

-(ListModel_FirstSection*)initWithTitle:(NSString*)title andSubtitle:(NSString* _Nullable)subtitle andWebUrl:(NSString* _Nullable)webUrl;
@end

NS_ASSUME_NONNULL_END
