//
//  main.m
//  LeetCode
//
//  Created by 岳琛 on 2019/1/18.
//  Copyright © 2019 KMF-Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");
    }
    return 0;
}

// 定义一个链表
struct ListNode {
    int val;
    struct ListNode * next;
};


//206. 反转链表
struct ListNode* reverseList1(struct ListNode * head) {
    if (!head) return NULL;
    
    struct ListNode * p = head->next;
    head->next = NULL;
    
    while (p != NULL) {
        struct ListNode * tmp = p->next;
        p->next = head;
        head = p;
        p = tmp;
    }
    return head;
}

//20ms
struct ListNode* reverseList2(struct ListNode * head) {
    if(!head) return NULL;
    
    struct ListNode *p = head, *newHead = head;
    
    while(head->next){
        p = head->next;
        head->next = p->next;
        p->next = newHead;
        newHead = p;
    }
    return newHead;
}


//21. 合并两个有序链表
struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2) {
    struct ListNode *p1,*p2,*head1,*head2,*temp1,*temp2;
    head1=l1;//第一链表头结点
    head2=l2;//第二链表头结点
    int data=0;
    
    p1=(struct ListNode*)malloc(sizeof(struct ListNode));
    p1->next=head1;
    temp1=p1;
    p2=(struct ListNode*)malloc(sizeof(struct ListNode));
    p2->next=head2;
    temp2=p2;
    
    if(l2==NULL) {
        return l1;
    }
    
    for(;head1!=NULL;)
    {
        for(;head2!=NULL;)
        {
            if(head1->val >= head2->val && head2->next != NULL && head1->val <= head2->next->val)//正常插入格式
            {
                p1->next = head1->next;
                head1->next = head2->next;
                head2->next = head1;
                break;
            }
            else if(head1->val<head2->val)//第二个链表的第一位数大于第一个链表的第一位数至第n位
            {
                p2->next = head1;
                p1->next = head1->next;
                head1->next = head2;
                p2 = p2->next;
                break;
            }
            else if(head2->next!=NULL)//没有找到合适的，第二个链表正常向后移动
            {
                p2 = p2->next;
                head2 = head2->next;
            }
            else if(head2->next==NULL&&head1->val>=head2->val)//l1的值大于l2的最后一个值
            {
                head2->next = head1;
                data=1;
                break;
            }
        }
        if(data==1) break;
        head2=p2->next;
        head1=p1->next;
    }
    return temp2->next;
}


//83. 删除排序链表中的重复元素
struct ListNode* deleteDuplicates(struct ListNode* head) {
    struct ListNode * tmp = head;
    
    while (tmp != NULL && tmp->next != NULL) {
        if (tmp->next->val == tmp->val) {
            tmp->next = tmp->next->next;
        } else {
            tmp = tmp->next;
        }
    }
    return head;
}

//82. 删除排序链表中的重复元素II
struct ListNode* deleteDuplicates2(struct ListNode* head) {
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* dummy1 = dummy;
    int issame = 1;
    while(head && head->next){
        
        //dummy前进到重复元素之前
        while(head->next && head->val != head->next->val){
            head = head->next;
            dummy = dummy->next;
            issame = 0;
        }
        //head1将重复元素只剩下一个；
        while(head->next && head->val == head->next->val){
            issame = 1;
            head->next = head->next->next;
        }
        //head1去重后到当前所有重复元素的下一个元素
        head = head->next;
        //先将dummy->next 指向head1;
        if(issame){
            dummy->next = head;
        }
    }
    //返回头结点dummy的next;
    return dummy1->next;
}

//203. 移除链表元素

struct ListNode* removeElements1(struct ListNode* head, int val) {
    if (head == NULL) {
        return NULL;
    }
    
    struct ListNode * cur = head;
    struct ListNode * tmp = NULL;
    
    while (cur->next) {
        if (cur->next->val == val) {
            tmp = cur->next;
            cur->next = tmp->next;
            free(tmp);
        } else {
            cur = cur -> next;
        }
    }
    
    if (head->val == val) {
        tmp = head->next;
        free(head);
        head = tmp;
    }
    
    return head;
    
}


struct ListNode* removeElements2(struct ListNode* head, int val) {
    if (head == NULL) {
        return NULL;
    }
    
    head->next = removeElements2(head->next, val);
    return head->val == val ? head->next : head;
}


struct ListNode *getIntersectionNode(struct ListNode *headA, struct ListNode *headB) {
    
    /**
     A链表的Head添加到B链表的尾部，若有环，必相交
     思路转变为查找环的点
     */
    
    /**
     定义两个指针AB，两个到达末尾的节点指向另一个链表的头部，如果两个指针移动了相同的距离，有交点就返回
     */
    if (!headA || !headB) {
        return NULL;
    }
    struct ListNode *curA = headA;
    struct ListNode *curB = headB;
    while (curA != curB) {
        curA = curA ? curA->next : headB;
        curB = curB ? curB->next : headA;
    }
    return curA;
    
    
}


/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

bool hasCycle(struct ListNode *head) {
    if (head == NULL || head->next == NULL) {
        return false;
    }
    
    struct ListNode *slow = head;
    struct ListNode *fast = head;
    
    // [1,2]
    while (fast != slow) {
        if (fast->next == NULL || fast->next->next == NULL) {
            return false;
        }
        
        slow = slow->next;
        fast = fast->next->next;
    }
    
    return false;
}
