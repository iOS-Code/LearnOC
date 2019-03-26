//
//  ViewController.h
//  SimpleDemo
//
//  Created by 岳琛 on 2019/1/15.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
@public
    NSString * _nameH;
@private
    NSUInteger _ageH;
@protected
    BOOL _sexH;
}

@end

@interface ViewController (category)

@end
