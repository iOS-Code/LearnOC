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
 
 主队列：
 主队列负责在主线程上调度任务，如果主线程已经在执行任务，
 
 */

/**
 
 */

#import "GCDVC.h"

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
