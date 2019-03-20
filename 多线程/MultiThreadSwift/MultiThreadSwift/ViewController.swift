//
//  ViewController.swift
//  MultiThreadSwift
//
//  Created by 岳琛 on 2019/3/11.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

/**
 Swift中多线程跟OC中方法类似
 
 1、Thread（灵活度高）
 2、Operation（队列+操作对象）
 3、GCD（调度队列+操作对象）
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        method1()
//        method2()
//        method3()
    }
    
}


// MARK: - Thread
extension ViewController {
    
    private func method1() -> Void {
        
        //1、手动启动的初始化 便利构造器
//        let myThread = Thread(target: self, selector: #selector(method1Action), object: nil)
//        myThread.name = "myThread"
//        myThread.start()
//
//        let anotherThread = Thread.init(target: self, selector: #selector(method1Action), object: nil)
//        anotherThread.name = "anotherThread"
//        anotherThread.start()
        
//        //2、事件响应 类方法
//        Thread.detachNewThread {
//            self.method1Action()
//        }
//
//        Thread.detachNewThreadSelector(#selector(method1PerformAction), toTarget: self, with: nil)
//
//        //3、使用当前对象创建线程
//        self.performSelector(inBackground: #selector(method1PerformAction), with: nil)
    }
    
    
    @objc private func method1Action() {
        print(Thread.current)
        print(Thread.current.isMainThread)
        print(Thread.isMultiThreaded())
    }
    
    @objc private func method1PerformAction() {
        print("method1PerformAction - Begin",Thread.current)
        
        // waitUntilDone:是否等待主线程执行完毕 才执行后续任务
        self.performSelector(onMainThread: #selector(method1PerformMainAction), with: nil, waitUntilDone: false)
        
        print("method1PerformAction - End",Thread.current)
        
    }

    @objc private func method1PerformMainAction() {
//        sleep(3)
        print(Thread.current)
        print(Thread.current.isMainThread)
        print(Thread.isMultiThreaded())
//        sleep(3)
    }
    
}

// MARK: - Operation
extension ViewController {
    private func method2() -> Void {
        /**
         Operation 任务
         OperationQueue 队列
         */
        
//        self.method_operation1()
//        self.method_operation2()
//        method_operation_queue1()
//        method_operation_queue2()
        method_operation_queue3()
    }
    
    // 当前线程执行Operation 「同步」
    private func method_operation1() {
        let operation = BlockOperation() {
            print("\(Thread.current)")
        }
        operation.start()
    }
    
    // 执行多个Operation 「当前线程或其他线程」
    private func method_operation2() {
        let operation = BlockOperation() {
            print("任务的当前线程:\(Thread.current)")
        }
        for i in 1...9 {
            operation.addExecutionBlock {
                print("\(Thread.current)  \(i)")
            }
        }
        operation.start()
    }
    
    // 创建队列
    /**
     主队列 任务加入主队列会自动执行 不需要调用start方法 添加到主队列的任务在主线程串行执行
     其他队列 任务会在其他线程执行
     */
    private func method_operation_queue1() {
        let queueOther = OperationQueue()
        queueOther.maxConcurrentOperationCount = 1//设置最大并发数
        
        let operation = BlockOperation()
        
        for i in 1...9 {
            operation.addExecutionBlock {
                print("\(Thread.current)  \(i)")
            }
        }
        
//        queueMain.addOperation(operation)
        queueOther.addOperation(operation)
        
    }
    
    // 创建队列并直接添加任务
    private func method_operation_queue2() {
        let queueMain = OperationQueue.main//主队列
        queueMain.addOperation {
            print("任务的当前线程:\(Thread.current)")
        }
        
        let queueOther = OperationQueue()//其他队列
        queueOther.addOperation {
            print("任务的当前线程:\(Thread.current)")
            
            OperationQueue.main.addOperation {
                print("任务的当前线程:\(Thread.current)")
            }
        }
    }
    
    // 任务依赖
    private func method_operation_queue3() {
        // 任务依赖可以在不同队列 跟队列没有关系
        let opera1 = BlockOperation() {
            print("开始执行任务1")
            Thread.sleep(forTimeInterval: 2)
            print("任务1")
        }
        opera1.completionBlock = {
            print("1111111")
            print(opera1.isExecuting, opera1.isFinished)//是否正在执行 是否执行完成
        }
        
        let opera2 = BlockOperation() {
            print("开始执行任务2")
            Thread.sleep(forTimeInterval: 2)
            print("任务2")
        }
        opera2.completionBlock = {
            print("2222222")
        }
        
        let opera3 = BlockOperation() {
            print("开始执行任务3")
            Thread.sleep(forTimeInterval: 2)
            print("任务3")
        }
        opera3.completionBlock = {
            print("3333333")
        }
        
        // 设置任务依赖
        opera2.addDependency(opera1)
        opera3.addDependency(opera2)
        
        let queue = OperationQueue()
        queue.addOperations([opera3, opera2, opera1], waitUntilFinished: false)
    }
}

// MARK: - GCD
extension ViewController {
    
    private func method3() -> Void {
        
        /**
         主队列：  「串行异步」
         全局队列：「并行同步」「并行异步」
         串行队列：「串行异步」
         并行队列：「并行同步」「并行异步」
         */
        
//        self.method_gcd_main()
//        self.method_gcd_global()
//        self.method_gcd_custom()
//        self.method_gcd_customGroup()
//        self.method_gcd_workItem()
        
//        self.methodAfter(after: 3) {
//            print("methodAfter")
//        }
//
//        self.methodTimer(timeInterval: 2) { (timer) in
//            print("methodTimer", Date())
//        }
//
//        self.methodCountTimer(timeInterval: 2, repeatcount: 5) { (timer, count) in
//            print("methodCountTimer", count)
//        }
    }
    
    // GCD 主队列 默认串行
    private func method_gcd_main() {
        
        // 常用方法
        let queue = DispatchQueue(label: "com.enhance.threadDownload")
        queue.async {
            print("耗时操作放入异步线程执行")
            Thread.sleep(forTimeInterval: 5)
            
            DispatchQueue.main.async {
                print("主线程更新")
            }
        }
        
        // 异步
        DispatchQueue.main.async {
            print("不会死锁")
        }
        
        // 同步
        let mainQueue = DispatchQueue.main
        mainQueue.sync {
            print("死锁")
        }
    }
    
    // GCD 全局队列 默认并行
    private func method_gcd_global() {
        for i in 1...99 {
            //同步 任务有序 前一个任务执行完毕才会执行下一个 操作会在当前线程执行
            DispatchQueue.global().sync {
                Thread.sleep(forTimeInterval: 1)
                print("全局并发同步:\(Thread.current)  任务标识:\(i)")
            }
            
            //异步 任务无序 随机执行 操作会在另外的线程执行
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 1)
                print("全局并发异步:\(Thread.current)  任务标识:\(i)")
            }
        }
    }
    
    // GCD 自定义队列
    private func method_gcd_custom() {
        
        /// label 队列标签
        /// qos 队列优先级「userInteractive -> userInitiated -> default -> utility -> background - unspecified」
        /// attributes 队列类型 默认是串行 concurrent表示并行
        /// autoreleaseFrequency 自动释放频率 「inherit 不确定 workItem 每个项目创建和排除自动释放池 never 不」
        /// target
//        let queue = DispatchQueue(label: "com.enhance.custom",
//                                  qos: DispatchQoS.default,
//                                  attributes: DispatchQueue.Attributes.concurrent,
//                                  autoreleaseFrequency: .workItem,
//                                  target: nil)
        
        
        // 异步串行队列
//        let queueYC = DispatchQueue(label: "com.enhance.customYC")
//        queueYC.async {
//            print("异步串行队列:\(Thread.current)")
//        }
        
        // 同步串行队列
//        let queueTC = DispatchQueue(label: "com.enhance.customTC")
//        queueTC.sync {
//            print("同步串行队列:\(Thread.current)")
//        }
        
//        // 同步串行不活跃队列
//        let queueTC_initiallyInactive = DispatchQueue(label: "com.enhance.customYC", qos: DispatchQoS.default, attributes: [.initiallyInactive], autoreleaseFrequency: .workItem, target: nil)
//        queueTC_initiallyInactive.sync {
//            print("同步串行不活跃队列:\(Thread.current)")
//        }
//        queueTC_initiallyInactive.activate()
//
//        // 异步并行不活跃队列
//        let queueYB_initiallyInactive = DispatchQueue(label: "com.enhance.customTC", qos: DispatchQoS.default, attributes: [.concurrent, .initiallyInactive], autoreleaseFrequency: .workItem, target: nil)
//        queueYB_initiallyInactive.async {
//            print("异步并行不活跃队列:\(Thread.current)")
//        }
//        queueYB_initiallyInactive.activate()
        
        
        // 同步并行队列
//        let queueTB = DispatchQueue(label: "com.enhance.customTC", qos: DispatchQoS.default, attributes: [.concurrent])
//
//        for i in 1...99 {
//            queueTB.sync {
//                Thread.sleep(forTimeInterval: 2)
//                print("同步并行队列:\(Thread.current)  任务标识:\(i)")
//            }
//        }
        
        // 异步并行队列
//        let queueYB = DispatchQueue(label: "com.enhance.customTC", qos: DispatchQoS.default, attributes: [.concurrent])
//
//        for i in 1...99 {
//            queueYB.async {
//                Thread.sleep(forTimeInterval: 2)
//                print("异步并行队列:\(Thread.current)  任务标识:\(i)")
//            }
//        }
        
        
    }
    
    // GCD 任务组
    private func method_gcd_customGroup() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.enhance.custom", qos: .default, attributes: .concurrent)
        
        for i in 1...55 {
            queue.async(group: group) {
                Thread.sleep(forTimeInterval: 2)
                print("并发异步线程\(Thread.current) 标识\(i)")
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("所有任务都已经完成\(Thread.current)")
        }
        
    }
    
    // GCD WorkItem
    private func method_gcd_workItem() {
        let queue = DispatchQueue(label: "com.custom.thread", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        let workItem = DispatchWorkItem {
            Thread.sleep(forTimeInterval: 2)
            print("线程\(Thread.current)正在执行任务")
        }
        queue.async(execute: workItem)
        
        print("before waiting")
//        workItem.wait()   //wait 会等待workItem执行完毕 再执行后续任务
        print("after waiting")
    }
    
    // GCD 倒计时
    private func methodCountTimer(timeInterval: Double, repeatcount: Int, handle:@escaping (DispatchSourceTimer?, Int)->()) {
        
        guard repeatcount > 0 else { return }
        
        var count = repeatcount
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count -= 1
            
            DispatchQueue.main.async {
                handle(timer, count)
            }
            
            if count == 0 { timer.cancel() }
        }
        
        timer.resume()
    }
    
    // GCD 定时器
    private func methodTimer(timeInterval: Double, handle:@escaping (DispatchSourceTimer?)->()) {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                handle(timer)
            }
        }
        timer.resume()
    }
    
    // GCD 延时操作
    private func methodAfter(after: Double, handle:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handle()
        }
    }
}

// MARK: - 线程间的同步
extension ViewController {
    
}
