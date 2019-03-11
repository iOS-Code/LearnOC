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
        method1()
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
        
        let operation = BlockOperation {
            
        }
        
    }
    
}

// MARK: - GCD
extension ViewController {
    
    private func method3() -> Void {
        
    }
}

