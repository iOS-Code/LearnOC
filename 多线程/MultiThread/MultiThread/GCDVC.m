//
//  GCDVC.m
//  MultiThread
//
//  Created by 岳琛 on 2019/3/7.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

/**
 关于GCD
 GCD自动管理线程的生命周期（创建、调度、销毁）
 
 任务：将要在线程中执行的代码，存在block中，将任务设置执行方式（同步或异步），等待CPU从队列中取出任务放在对应线程中执行
 同步：sync 一个接一个执行，前一个没有执行完后面的不执行，不开线程
 异步：async 开启多个线程 任务同一时间可以一起执行 异步是多线程的代名词
 
 队列：装在线程任务的队形结构（先进先出的方式调度队列中的任务）「串行或并发」
 并发队列：线程可以同时执行。实际上是CPU在多个线程中快速切换。并发只在异步生效。
 串行队列：线程执行按序执行。
 
 将任务「Block」添加到队列「自己创建队列 全局并发队列」指定任务的执行方式「dispatch_async异步 dispatch_sync同步」
 */

/**
 GCD的队列：
 
 通过dispatch_queue_create来创建队列对象，传入两个参数
 参数1：队列的唯一标识，可空
 参数2：串行「DISPATCH_QUEUE_SERIAL」  并发「DISPATCH_QUEUE_CONCURRENT」
 
 dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
 dispatch_queue_t queue1 = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
 
 其他队列：
 
 1、主队列：
 主队列负责在主线程上调度任务，如果主线程已经在执行任务，主队列会等主线程空闲后再调度任务
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
    // 耗时操作放在这里
    dispatch_async(dispatch_get_main_queue(), ^{
        // 回到主线程进行UI操作
    });
 });
 
 2、全局并发队列：
 全局并发队列就是一个并发队列，为了让我们更方便的使用多线程
 
 //全局并发队列
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 //iOS8开始使用服务质量，现在获取全局并发队列时，可以直接传0
 dispatch_get_global_queue(0, 0);
 
 //全局并发队列的优先级
 #define DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高优先级
 #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）优先级
 #define DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低优先级
 #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台优先级
 */

/**
 关于任务
 任务就是多线程中即将要执行的代码，用block将这段代码封装
 
 1、同步（sync）使用dispatch_sync
 2、异步（async）使用dispatch_async
 
 // 同步执行任务
 dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    // 任务放在这个block里
    NSLog(@"我是同步执行的任务");
 });
 
 // 异步执行任务
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
    // 任务放在这个block里
    NSLog(@"我是异步执行的任务");
 });
 
 */

/**
 「串行队列、并发队列、主队列」  + 「同步、异步」
 
 1、串行同步
 2、串行异步
 3、并发同步
 4、并发异步
 5、主队列同步
 6、主队列异步
 */

#import "GCDVC.h"

@implementation GCDVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self method_groupGCD];
}

#pragma mark - GCD

/** 串行同步 */
- (IBAction)syncSerial:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    /**
     串行同步 执行完一个任务才继续执行后续任务 不会开启新线程
     */
    
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    // 同步执行事件1
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 同步执行事件2
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 同步执行事件3
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
}

/** 串行异步 */
- (IBAction)asyncSerial:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    /**
     串行异步 异步就会开启新线程 由于任务是串行 所以任务仍然是按照顺序执行
     */
    
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    // 异步执行事件1
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件2
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件3
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
}

/** 并发同步 */
- (IBAction)syncConcurrent:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    /**
     并发同步 因为是同步的 所以执行完一个任务在执行后续任务 不会开启新线程
     */
    
    // 创建并行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 同步执行事件1
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 同步执行事件2
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 同步执行事件3
    dispatch_sync(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
}

/** 并发异步 */
- (IBAction)asyncConcurrent:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    /**
     开启多线程 任务根据系统调度执行
     */
    
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"************ 异步执行事件1 ************");
    dispatch_async(queue, ^{
        for (int i=1; i<9; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    NSLog(@"************ 异步执行事件2 ************");
    dispatch_async(queue, ^{
        for (int i=1; i<9; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    NSLog(@"************ 异步执行事件3 ************");
    dispatch_async(queue, ^{
        for (int i=1; i<9; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
}

/** 主队列同步 */
- (IBAction)syncMainQueue:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    // 主队列中执行同步操作1
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"\n%@", NSThread.currentThread);
    });
    
    // 主队列中执行同步操作2
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"\n%@", NSThread.currentThread);
    });
    
    /**
     在主线程中执行「主队列同步」，会产生死锁
     
     1、在主线程中使用主队列同步，把任务放在主线程的队列中，同步针对事件是立即执行；
     2、事件放在主队列中同步执行，会立即实行
     3、主线程正在处理syncMain方法，任务需要等待syncMain方法执行完才能执行；
     4、syncMain方法执行到主队列的同步事件1时，又需要等待它执行完毕才能执行后续任务2；
     5、这样syncMain方法和事件1形成相互等待，产生了死锁；
     */
}

/** 主队列异步 */
- (IBAction)asyncMainQueue:(UIButton *)sender
{
    NSLog(@"************ 实例 ************");
    
    /**
     主线程中任务按顺序执行；
     */
    
    // 获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 异步执行事件1
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件2
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件3
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
}

#pragma mark - GCD的通信

// 简单模拟
- (void)method_communicationGCD
{
    /**
     模拟一个耗时操作的异步执行，并返回主线程更新数据
     */
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 执行耗时操作
        NSLog(@"\n%@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:3];
        
        // 返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"\n%@", NSThread.currentThread);
        });
    });
}

// 任务分组
- (void)method_barrierGCD
{
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 异步执行事件1
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「1」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件2
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「2」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // GCD的分组方法 只有事件12执行完毕 才会执行事件34 并且事件都是异步并发执行
    dispatch_barrier_async(queue, ^{
        NSLog(@"\n%@", NSThread.currentThread);
    });
    
    // 异步执行事件3
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「3」%@「%d」", NSThread.currentThread, i);
        }
    });
    
    // 异步执行事件4
    dispatch_async(queue, ^{
        for (int i=1; i<4; i++) {
            NSLog(@"\n「4」%@「%d」", NSThread.currentThread, i);
        }
    });
}

/// 延迟执行
- (void)method_afterGCD
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 延迟5S执行事件
        NSLog(@"\n%@", NSThread.currentThread);
    });
}

/// 单次执行
- (void)method_onceGCD
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"\n%@", NSThread.currentThread);
    });
}

/// 快速遍历
- (void)method_applyGCD
{
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 并发队列中执行遍历任务
    dispatch_apply(7, queue, ^(size_t index) {
        NSLog(@"\n「CONCURRENT」%@「%zd」", NSThread.currentThread, index);
    });
    
    // 串行队列
    dispatch_queue_t queue2 = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    // 串行队列中执行遍历任务
    dispatch_apply(7, queue2, ^(size_t index) {
        NSLog(@"\n「SERIAL」%@「%zd」", NSThread.currentThread, index);
    });
}

/// 队列分组
- (void)method_groupGCD
{
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 异步执行任务1
    dispatch_group_async(group, queue, ^{
        NSLog(@"\n「1」%@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"\n「1」%@", NSThread.currentThread);
    });
    
    // 异步执行任务2
    dispatch_group_async(group, queue, ^{
        NSLog(@"\n「2」%@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"\n「2」%@", NSThread.currentThread);
    });
    
    // 队列组的监听事件
    dispatch_group_notify(group, queue, ^{
        NSLog(@"\n「notify」%@", NSThread.currentThread);
    });
    
}

@end
