//
//  NSObject+runtime.m
//  OCRuntime
//
//  Created by 岳琛 on 2019/3/25.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import "NSObject+runtime.h"

@implementation NSObject (runtime)

- (void)printAllPropertyCount
{
    unsigned int count = 0;
    objc_property_t *proList = class_copyPropertyList([self class], &count);
    NSLog(@"属性的数量 %d", count);
}

+ (NSArray *)getPersonArray
{
    // 调用运行时方法，取得类的属性列表
    // Ivar 成员变量
    // Method 方法
    // Property 属性
    // Protocol 协议
    
    /**
     1. 要获取的类
     2. 类属性的个数指针
     3. 返回值:所有属性的数组 C中数组的名字指向第一个元素的地址
     
     retain/create/copy 需要 release，最好 option + click
     */
    unsigned int count = 0;
    objc_property_t *proList = class_copyPropertyList([self class], &count);
    NSLog(@"属性的数量 %d", count);
    
    // 遍历所有的属性
    for (unsigned int i = 0; i < count; i++) {
        // 1. 从数组中取得属性
        objc_property_t pty = proList[i];
        // 2. 从 pty 中获得属性的名称
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@", name);
    }

    free(proList);
    return nil;
}

+ (NSArray *)resetPersonProperty
{
    const char * kPropertiesListKey = "CZPropertiesListKey";
    
    NSArray *ptyList = objc_getAssociatedObject(self, kPropertiesListKey);
    if (ptyList != nil) {
        return ptyList;
    }
    
    // 调用运行时方法，取得类的属性列表
    // Ivar 成员变量
    // Method 方法
    // Property 属性
    // Protocol 协议
    
    unsigned int count = 0;
    objc_property_t *proList = class_copyPropertyList([self class], &count);
    NSLog(@"属性的数量 %d", count);
    
    // 创建数组
    NSMutableArray *arrayM = [NSMutableArray array];
    // 遍历所有的属性
    for (unsigned int i = 0; i < count; i++) {
        // 1. 从数组中取得属性
        objc_property_t pty = proList[i];
        // 2. 从 pty 中获得属性的名称
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@", name);
        // 3. 属性名称添加到数组
        [arrayM addObject:name];
    }
    
    // 释放数组
    free(proList);
    
    /**
     对象的属性数组已经获取完毕，利用关联对象，动态添加属性
     1. 对象 self [OC 中 class 也是一个特殊的对象]
     2. 动态添加属性的 key，获取值的时候使用
     3. 动态添加的属性值
     4. 对象的引用关系
     */
    objc_setAssociatedObject(self, kPropertiesListKey, arrayM.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return arrayM.copy;
}
@end
