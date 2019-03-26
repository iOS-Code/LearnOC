import UIKit
import Foundation


class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val : Int) {
        self.val = val
        self.next = nil
    }
}

class List {
    var head: ListNode?
    var tail: ListNode?
    
    // 尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    // 头插法
    func appendToHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let tmp = ListNode(val)
            tmp.next = head
            head = tmp
        }
    }
}

// 判断链表有环
func hasCycle(_ head : ListNode?) -> Bool {
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
}

func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
    guard let head = head else {
        return nil
    }
    
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    // 设置后一个节点初始位置
    for _ in 0 ..< n {
        if post == nil {
            break
        }
        post = post!.next
    }
    
    // 同时移动前后节点
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    // 删除节点
    prev!.next = prev!.next!.next
    
    return dummy.next
}


class Solution {
    
    func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
//        guard let head = head else {
//            return nil
//        }
        
        let dummy = ListNode(0)
        dummy.next = head
        var prev: ListNode? = dummy
        var post: ListNode? = dummy
        
        // 设置后一个节点初始位置
        for _ in 0 ..< n {
            if post == nil {
                break
            }
            post = post!.next
        }
        
        // 同时移动前后节点
        while post != nil && post!.next != nil {
            prev = prev!.next
            post = post!.next
        }
        
        // 删除节点
        prev!.next = prev!.next!.next
        
        return dummy.next
    }
    
    
    func removeElements1(_ head: ListNode?, _ val: Int) -> ListNode? {
        guard head != nil else {
            return nil
        }
        
        let dummy = ListNode(0)
        dummy.next = head
        
        var cur: ListNode = dummy
        
        while cur.next != nil {
            if cur.next?.val == val {
                cur.next = cur.next?.next
            } else {
                cur = cur.next!
            }
        }
        
        return dummy.next
    }
    
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        guard head != nil else {
            return nil
        }
        
        head?.next = removeElements(head?.next, val)
        return head?.val == val ? head?.next : head
    }
    
    // 回文链表
    func isPalindrome1(_ head: ListNode?) -> Bool {
       
        if head == nil || head?.next == nil {
            return true
        }
        
        var fast: ListNode = head!
        var slow: ListNode = head!
        
        while fast.next != nil && fast.next?.next != nil {
            fast = (fast.next?.next)!
            slow = slow.next!
        }
        
        slow = reverse(slow.next!)
        var newHead = head
        
        while slow != nil {
            if newHead?.val != slow.val {
                return false
            }
            
            newHead = newHead?.next
            slow = slow.next!
        }
        return true
    }
    
    func reverse(_ head: ListNode) -> ListNode {
        if head.next == nil {
            return head
        }
        
        let newHead: ListNode = reverse(head.next!)
        head.next?.next = head
        head.next = nil
        return newHead
    }
    
    func repeatedNTimes(_ A: [Int]) -> Int {
        var tmp = Array<Int>()
        
        for (_,value) in A.enumerated() {
            if tmp.contains(value) {
                return value
            } else {
                tmp.append(value)
            }
        }
        return 0
    }
    
    func findWords(_ words: [String]) -> [String] {
        var tmp: [String] = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
        var result = [String]()
        
        
        for item in words {
            
            var dic: [String: Int] = ["q":0,"a":0,"z":0]
            
            for char in item.characters {
                
                let string1: String = tmp.first!
                if string1.contains(char) {
                    dic["q"] = 1
                }
                
                let string2: String = tmp[1]
                if string2.contains(char) {
                    dic["a"] = 1
                }
                
                let string3: String = tmp.last!
                if string3.contains(char) {
                    dic["z"] = 1
                }
            }
            
            let finallyCount:Int = dic["q"]! + dic["a"]! + dic["z"]!
            
            if finallyCount == 1 {
                result.append(item)
            }
        }
        
        return result
        
    }
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        let s = Set<Int>.init(nums1)
        var result = Set<Int>()
        
        for value in nums2 {
            if(s.contains(value) && !result.contains(value)){
                result.insert(value)
            }
        }
        return Array(result)
    }
    
    func findTheDifference(_ s: String, _ t: String) -> Character {
        
        var result = [String : Int]()
        
        for item in s.characters {
            if result.keys.contains(String(item)) {
                let value = result[String(item)]
                result[String(item)] = (value ?? 0) + 1
            } else {
                result[String(item)] = 1
            }
        }
        
        for item in t.characters {
            if result.keys.contains(String(item)) {
                let value = result[String(item)]
                result[String(item)] = (value ?? 0) + 1
            } else {
                result[String(item)] = 1
            }
        }
        
        for (key,value) in result {
            if value%2 != 0 {
                return Character(key)
            }
        }
        
        return Character("0")
        
    }
    
    
    func majorityElement(_ nums: [Int]) -> Int {
        var result = [Int:Int]()
        
        for item in nums {
            if result.keys.contains(item) {
                let value: Int = result[item] ?? 0
                result[item] = value + 1
            } else {
                result[item] = 1
            }
        }
        
        for (key, value) in result {
            if value > nums.count/2 {
                return key
            }
        }
        
        return 0
    }
    
    
    func uncommonFromSentences(_ A: String, _ B: String) -> [String] {
        
        var result: [Substring: Int] = [:]
        var array = [String]()
        
        for item in A.split(separator: " ") {
            result[item] = (result[item] ?? 0) + 1
        }
        
        for item in B.split(separator: " ") {
            result[item] = (result[item] ?? 0) + 1
        }
        
        for (key, value) in result {
            if value == 1 {
                array.append(String(key))
            }
        }
        
        return array
    }
    
    
    
    func uncommonFromSentences2(_ A: String, _ B: String) -> [String] {
        
        let tmp1 = A.components(separatedBy: " ")
        let tmp2 = B.components(separatedBy: " ")
        var result = [String: Int]()
        var array = [String]()
        
        
        tmp1.forEach { (item) in
            if result.keys.contains(item) {
                let value = result[item] ?? 0
                result[item] = value + 1
            } else {
                result[item] = 1
            }
        }
        
        tmp2.forEach { (item) in
            if result.keys.contains(item) {
                let value = result[item] ?? 0
                result[item] = value + 1
            } else {
                result[item] = 1
            }
        }
        
        result.forEach { (key:String, value:Int) in
            if value == 1 {
                array.append(key)
            }
        }
        
        return array
        
    }
    
    
}


/**
 * Your MyHashMap object will be instantiated and called as such:
 * let obj = MyHashMap()
 * obj.put(key, value)
 * let ret_2: Int = obj.get(key)
 * obj.remove(key)
 */
class MyHashMap {
    
    let buket: Int = 1000
    let item = 1001
    var table = [[Any]]()
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    private func hash(_ key: Int) -> Int {
        return key/buket;
    }
    
    private func pos(_ key: Int) -> Int {
        return key%buket;
    }
    
    /** value will always be non-negative. */
    func put(_ key: Int, _ value: Int) {
        let hash:Int = self.hash(key)
        let pos:Int = self.pos(key)
        
        if(table[hash] == nil){
            table[hash] = [Int]()
            while table[hash].count < item {
                table[hash].append(-1)
            }
        }
        
        table[hash][pos] = value;
    }
    
    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
    func get(_ key: Int) -> Int {
        let hash:Int = self.hash(key)
        let pos:Int = self.pos(key)
        if(table[hash] == nil){
            return -1
        }
        return table[hash][pos] as! Int
    }
    
    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
    func remove(_ key: Int) {
        let hash:Int = self.hash(key)
        let pos:Int = self.pos(key)
        
        if(table[hash] != nil){
            table[hash][pos] = -1
        }
    }
}
