//
//  ViewController.swift
//  SwiftRuntime
//
//  Created by 岳琛 on 2019/3/25.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

import UIKit

class TestSwiftClass {
    @objc var aBoll : Bool = true
    @objc var aInt : Int = 0
    @objc var aFloat : Float = 123.45
    var aDouble : Double = 1234.567
    var aString :String = "abc"
    var aObject : AnyObject! = nil
    
    func testReturn(key: UIView) -> Void {
        print("TestSwiftClass.testReturn")
    }
}

class ViewController: UIViewController {
    var aBoll : Bool = true
    var aInt : Int = 0
    var aFloat : Float = 123.45
    var aDouble : Double = 1234.567
    var aString :String = "abc"
    var aObject : AnyObject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aSwiftClass:TestSwiftClass = TestSwiftClass()
        showClsRuntime(cls: object_getClass(aSwiftClass)!)
        print("\n\n\n")
        showClsRuntime(cls: object_getClass(self)!)
        
        /**
         Swift类的函数调用在编译时就确定了调用函数，无法通过runtime获取方法、属性；「添加OBJCs修饰可以」
         继承自UIViewController的控制器基类是NSObject，Swift为了兼容OC，凡是继承自NSObject的类都会保留动态性，可以通过runtime获取方法
         */
        
        /**
         Swift类没有动态性，但是在方法、属性前添加@dynamic可以获得动态性
         */
    }
    
    func testReturn(key: UIView) -> Void {
        print("TestSwiftClass.testReturn")
    }
    
    func testReturnVoid(aBoll: Bool, aInteger: Int, aFloat: Float, aString: String, aObject: AnyObject) -> Void {
        print("testSwiftVC.testReturnVoid")
    }
    
    func testReturnTuple(aBool : Bool , aInteger : Int , aFloat : Float) -> (Bool , Int , Float){
        print("testSwiftVC.testReturnTuple")
        return (aBool,aInteger,aFloat)
    }
    
    func testReturnVoidWithCharacter(aCharacter : Character ) {
        print("testSwiftVC.testReturnVoidWithCharacter")
    }
    
    func tableView(table : UITableView , numberOfRowsInSection section : Int) -> Int {
        print("testSwiftVC.tableView(table : UITableView , numberOfRowsInSection section : Int) -> Int")
        return 20
    }
}

extension ViewController {
    
    func showClsRuntime (cls : AnyClass)  {
        print("start methodList")
        var  methodNum : UInt32 = 0
        let methodList = class_copyMethodList(cls, &methodNum)
        for index in 0..<numericCast(methodNum) {
            let method : Method = methodList![index]
            print(method_getTypeEncoding(method))
            print(method_copyReturnType(method))
            print(String(_sel: method_getName(method)))
        }
        free(methodList)
        print("end methodList")
        
        print("start propertyList")
        
        var propertyNum : UInt32 = 0
        let propertyList = class_copyPropertyList(cls, &propertyNum)
        for index in 0..<numericCast(propertyNum) {
            let property : objc_property_t = propertyList![index]
            print(property_getName(property))
            print(property_getAttributes(property))
        }
        free(propertyList)
        print("end propertyList")
        
    }

}
