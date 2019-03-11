//
//  NSThreadVC.m
//  MultiThread
//
//  Created by 岳琛 on 2019/3/7.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

/**
 NSThread的创建方式
 
 1、通过init进行初始化 创建完成手动启动
 2、detachNewThreadWithBlock 创建完成自动启动
 3、performSelectorInBackground 创建完成自动启动
 */

/**
 NSThread的常用方法
 
 1、获取线程
 [NSThread mainThread] 获取主线程对象「number=1，name=main」
 [NSThread currentThread] 获取当前线程
 2、休眠
 [NSThread sleepForTimeInterval:2];
 [NSThread sleepUntilDate:[NSDate date]];
 3、线程判断
 [NSThread exit] 退出线程
 [NSThread isMainThread] 当前线程是否是主线程
 [NSThread isMultiThreaded] 当前线程是否是多线程
 */

/**
 NSThread的常用属性
 
 1、线程优先级「0.0----1.0」 默认为0.5，优先级最高为1.0，CPU调度的频率高
 tmp.threadPriority
 2、
 tmp.isFinished 是否已完成
 tmp.isExecuting 是否在执行
 tmp.isCancelled 是否被取消
 tmp.isMainThread 是否主线程
 */

#import "NSThreadVC.h"

@implementation NSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)method1:(UIButton *)sender {
    NSThread * tmp = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod:) object:@"method111"];
    [tmp setName:@"thread111"];
    [tmp start];// 调用start函数手动启动
}

- (IBAction)method2:(UIButton *)sender {
    // 通过Block
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"[%@]", [NSThread currentThread]);
    }];
    
    // 通过回调函数
    [NSThread detachNewThreadSelector:@selector(threadMethod:) toTarget:self withObject:@"method222"];
}

- (void)threadMethod:(NSObject *)obj {
    NSLog(@"[%@]:%@", [NSThread currentThread], obj);
}

- (IBAction)method3:(UIButton *)sender {
    // 使用Self创建多线程 执行对象方法
    [self performSelectorInBackground:@selector(multiThreadMethod) withObject:nil];
}

/**
 关于waitUntilDone参数
 
 waitUntilDone = YES「等待主线程事件执行完成，才执行后续事件」
 waitUntilDone = NO「立即执行子线程的后续事件」
 */

- (void)multiThreadMethod {
    NSLog(@"「Before MainThread」");
    [self performSelectorOnMainThread:@selector(mainThreadMethod) withObject:nil waitUntilDone:NO];// 唤醒主线程 执行UI操作
    NSLog(@"「After MainThread」");
}

- (void)mainThreadMethod {
    [NSThread sleepForTimeInterval:1];
    NSLog(@"[%@]", [NSThread currentThread]);
}

@end
