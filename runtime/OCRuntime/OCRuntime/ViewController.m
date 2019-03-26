//
//  ViewController.m
//  OCRuntime
//
//  Created by 岳琛 on 2019/3/25.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self method_test1];
}

/** 1、动态获取类的属性 */
- (void)method_test1
{
    Person * p = [[Person alloc] init];
    [p printAllPropertyCount];
    [Person getPersonArray];
    [Person resetPersonProperty];
    [p printAllPropertyCount];
}

@end
