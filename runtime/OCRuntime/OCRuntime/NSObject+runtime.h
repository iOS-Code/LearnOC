//
//  NSObject+runtime.h
//  OCRuntime
//
//  Created by 岳琛 on 2019/3/25.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (runtime)

+ (NSArray *)getPersonArray;
+ (NSArray *)resetPersonProperty;

- (void)printAllPropertyCount;

@end

NS_ASSUME_NONNULL_END
