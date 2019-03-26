//
//  main.m
//  SimpleDemo
//
//  Created by 岳琛 on 2019/1/15.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/** 删除链表中的节点 */
/**
 请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点，你将只被给定要求被删除的节点。
 现有一个链表 -- head = [4,5,1,9]，它可以表示为:
 4 -> 5 -> 1 -> 9
 */

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
//void deleteNode(struct ListNode* node) {
//    if (node == NULL) {
//        return;
//    }
//    node->val = node->next->val;
//    node->next = node->next->next;
//}
