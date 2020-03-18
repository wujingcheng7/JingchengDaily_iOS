//
//  AppDelegate.h
//  京城日报
//
//  Created by 吴京城 on 2020/3/16.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

