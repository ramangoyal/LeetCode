//
//  ViewController.swift
//  LeetCodeDataStructure
//
//  Created by Raman Goyal on 04/05/19.
//  Copyright © 2019 Raman Goyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        permute([1,2,3])
    }


}

//MARK:- LeetCode Easy Problems
extension ViewController {
    //https://leetcode.com/problems/permutations/
    func permute(_ nums: [Int]) -> [[Int]] {
        var outputArray: [[Int]] = []
        for element in nums {
            var startIndex = 0
            var endIndex = nums.count - 1
            while (startIndex != nums.count-1 || endIndex > -1) {
                if element == nums[startIndex] {
                    startIndex += 1
                    continue
                } else if element == nums[endIndex] {
                    endIndex -= 1
                    continue
                }
                let array = [element, nums[startIndex], nums[endIndex]]
                outputArray.append(array)
                if startIndex != nums.count-1 {
                    startIndex += 1
                }
                endIndex -= 1
            }
        }
        return outputArray
    }
    
    //https://leetcode.com/problems/remove-nth-node-from-end-of-list/
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head?.next == nil {
            return nil
        }
        var dummy: ListNode? = ListNode(0)
        dummy = head
        var first = dummy
        var second = dummy
        for _ in 0..<n+1 {
            first = first?.next
        }
        while first != nil {
            first = first?.next
            second = second?.next
        }
        second?.next = second?.next?.next
        return dummy
    }
    
    //https://leetcode.com/problems/two-sum/
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dictNumber: [Int: Int] = [:]
        for number in nums {
            dictNumber[number] = number
        }
        
        for (index, number) in nums.enumerated() {
            let diff = target - number
            if let dictNum = dictNumber[diff], dictNum == diff,
                let dictNumIndex = nums.firstIndex(of: dictNum), dictNumIndex != index {
                return [index, dictNumIndex]
            }
        }
        return []
    }
    
    //https://leetcode.com/problems/valid-parentheses/
    func isValid(_ s: String) -> Bool {
        let stack = Stack()
        var dict: [String: String] = [:]
        dict["("] = ")"
        dict["{"] = "}"
        dict["["] = "]"
        
        for char in s {
            if dict.keys.contains(String(char)) {
                stack.push(input: String(char))
            } else if dict.values.contains(String(char)) {
                if let element = stack.pop(), let dictElement = dict[element] {
                    if dictElement != String(char) {
                        return false
                    }
                } else {
                    stack.push(input: String(char))
                }
            }
        }
        return stack.isEmpty()
    }
    
    //https://leetcode.com/problems/merge-two-sorted-lists/
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var resultList: ListNode?
        var sortingPointer: ListNode?
        var list1 = l1
        var list2 = l2
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        if list1 != nil && list2 != nil {
            if list1!.val <= list2!.val {
                sortingPointer = list1
                list1 = sortingPointer?.next
            } else {
                sortingPointer = list2
                list2 = sortingPointer?.next
            }
        }
        resultList = sortingPointer
        
        while list1 != nil && list2 != nil {
            if list1!.val <= list2!.val {
                sortingPointer?.next = list1
                sortingPointer = list1
                list1 = sortingPointer?.next
            }else {
                sortingPointer?.next = list2
                sortingPointer = list2
                list2 = sortingPointer?.next
            }
        }
        
        if list1 == nil {
            sortingPointer?.next = list2
        }
        if list2 == nil {
            sortingPointer?.next = list1
        }

        return resultList
    }
    
    //https://leetcode.com/problems/maximum-subarray/
    func maxSubArray(_ nums: [Int]) -> Int {
        var maxSum = nums[0]
        var sumSoFar = 0
        var startIndex = 0
        var endIndex = 0
        var tempIndex = 0
        for (index,value) in nums.enumerated() {
            sumSoFar = sumSoFar + value
            if sumSoFar > maxSum {
                maxSum = sumSoFar
                endIndex = index
                startIndex = tempIndex
            }
            if sumSoFar <= 0 {
                sumSoFar = 0
                tempIndex = index + 1
            }
        }
        print(nums[startIndex...endIndex])
        return maxSum
    }
    
    //https://leetcode.com/problems/climbing-stairs/
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        
        var first = 1
        var second = 2
        for _ in 2..<n {
            let third = first + second
            first = second
            second = third
        }
        return second
    }
    
    //https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count > 0 {
            var minPrice = prices[0]
            var maxProfit = 0
            for price in prices {
                if price < minPrice {
                    minPrice = price
                }else if (price - minPrice) > maxProfit {
                    maxProfit = price - minPrice
                }
            }
            return maxProfit
        }
        return 0
    }
    
    //https://leetcode.com/problems/single-number/
    func singleNumber(_ nums: [Int]) -> Int {
        var dict: [Int: Int] = [:]
        for element in nums {
            if let _ = dict[element] {
                dict[element] = nil
            }else {
                dict[element] = 1
            }
        }
        return Array(dict.keys)[0]
    }
    
    //https://leetcode.com/problems/linked-list-cycle/
    func hasCycle(head: ListNode?) -> Bool {
        if (head == nil) || (head?.next == nil) {
            return false
        }
        var slowPointer = head
        var fastPointer = head?.next
        while (slowPointer!.val != fastPointer?.val) && (slowPointer!.next! != (fastPointer?.next!)!) {
            if fastPointer == nil || slowPointer == nil {
                return false
            }
            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next?.next
        }
        return true
    }
    
    //https://leetcode.com/problems/majority-element/
    func majorityElement(_ nums: [Int]) -> Int {
        var dict: [Int: Int] = [:]
        for element in nums {
            if let count = dict[element] {
                dict[element] = count + 1
            }else {
                dict[element] = 1
            }
        }
        
        var maxElement = 0
        var targetElement = 0
        for (key, value) in dict {
            if value > maxElement {
                maxElement = value
                targetElement = key
            }
        }
        return targetElement
    }
    
    //https://leetcode.com/problems/house-robber/
    func rob(_ nums: [Int]) -> Int {
        let length = nums.count
        if length == 0 {
            return 0
        }
        var value1 = nums[0]
        if length == 1 {
            return value1
        }
        var value2 = max(nums[0], nums[1])
        if length == 2 {
            return value2
        }
        
        var maxSum = 0
        for value in nums[2..<nums.count] {
            maxSum = max(value1+value, value2)
            value1 = value2
            value2 = maxSum
        }
        return maxSum
    }
    
    //https://leetcode.com/problems/valid-palindrome/submissions/
    func isPalindrome(_ s: String) -> Bool {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        let inputString = String(s.filter {okayChars.contains($0) })
        let charsArray = Array(inputString)
        var isValid = true
        for index in 0..<charsArray.count {
            let startCharacter = charsArray[index].uppercased()
            let lastCharacter = charsArray[inputString.count-1-index].uppercased()
            if startCharacter == lastCharacter {
                continue
            }else {
                isValid = false
                break
            }
        }
        return isValid
    }
    
    //https://leetcode.com/problems/reverse-linked-list/submissions/
    func reverseList(_ head: ListNode?) -> ListNode? {
        var curr = head
        var prev: ListNode? = nil
        while (curr != nil) {
            let temp = curr?.next
            curr?.next = prev
            prev = curr
            curr = temp
        }
        return prev
    }
    
    //https://leetcode.com/problems/move-zeroes/submissions/
    func moveZeroes(_ nums: inout [Int]) {
        var nonZeroIndex = 0
        for index in 0..<nums.count {
            if nums[index] != 0 {
                nums[nonZeroIndex] = nums[index]
                nonZeroIndex += 1
            }
        }
        
        for index in nonZeroIndex..<nums.count {
            nums[index] = 0
        }
    }
    
    //https://leetcode.com/problems/find-all-duplicates-in-an-array/submissions/
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var dict: [Int: Int] = [:]
        for element in nums {
            if let count = dict[element] {
                dict[element] = count + 1
            }else {
                dict[element] = 1
            }
        }
        var outputArray: [Int] = []
        for (key, value) in dict {
            if value == 2 {
                outputArray.append(key)
            }
            
        }
        return outputArray
    }
    
    //https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/submissions/
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        if nums.count > 0 {
            var dict: [Int: Int] = [:]
            for index in 1...nums.count {
                dict[index] = index
            }
            
            for number in nums {
                dict[number] = nil
            }
            return Array(dict.keys)
        }
        return []
    }
    
    //https://leetcode.com/problems/add-two-numbers/
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry: Int = 0
        var outputList: ListNode?
        var dummyList: ListNode?
        var list1 = l1
        var list2 = l2
        while (list1 != nil || list2 != nil) {
            let value1 = list1?.val ?? 0
            let value2 = list2?.val ?? 0
            let result = value1 + value2 + carry
            carry = result/10
            if outputList == nil {
                outputList = ListNode(result % 10)
                dummyList = outputList
            }else {
                dummyList?.next = ListNode(result % 10)
                dummyList = dummyList?.next
            }
            if list1 != nil {
                list1 = list1?.next
            }
            if list2 != nil {
                list2 = list2?.next
            }
        }
        if carry > 0 {
            dummyList?.next = ListNode(carry)
        }
        return outputList
    }
    
    //https://leetcode.com/problems/longest-substring-without-repeating-characters/
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var tempArray: [Character] = []
        var maxLength: Int = 0
        for character in s {
            if tempArray.contains(character) {
                if let index = tempArray.index(of: character) {
                    tempArray = Array(tempArray[index+1..<tempArray.count])
                    tempArray.append(character)
                    if tempArray.count > maxLength {
                        maxLength = tempArray.count
                    }
                }
            }else {
                tempArray.append(character)
                if tempArray.count > maxLength {
                    maxLength = tempArray.count
                }
            }
        }
        return maxLength
    }
//    func lengthOfLongestSubstring(_ s: String) -> Int {
//        var tempSet = Set<Character>()
//        var maxLength: Int = 0
//        var i = 0
//        var j = 0
//        while (i < s.count && j < s.count) {
//            if tempSet.contains(Array(s)[j]) {
//                tempSet.remove(Array(s)[i])
//                i += 1
//            }else {
//                tempSet.insert(Array(s)[j])
//                j += 1
//                if tempSet.count > maxLength {
//                    maxLength = tempSet.count
//                }
//            }
//        }
//        return maxLength
//    }

    //https://leetcode.com/problems/3sum/
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let inputNums = nums.sorted()
        var outputArray: [[Int]] = []
        for (index, element) in inputNums.enumerated() {
            var startIndex = index + 1
            var endIndex = inputNums.count - 1
            while (startIndex < endIndex) {
                let startNumber = inputNums[startIndex]
                let endNumber = inputNums[endIndex]
                let targetSum = 0 - element
                let tempSum = startNumber + endNumber
                if tempSum == targetSum {
                    let array  = [element, startNumber, endNumber]
                    outputArray.append(array)
                    break
                }else if tempSum > targetSum {
                    endIndex -= 1
                }else {
                    startIndex += 1
                }
            }
        }
        return outputArray
    }


}

//MARK:- ListNode
public class ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
    
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    
}

//MARK:- Stack
class Stack {
    var stackArray: [String] = [String]()
    
    func push(input: String) {
        stackArray.append(input)
    }
    
    func pop() -> String? {
        if let lastElement = stackArray.last {
            stackArray.removeLast()
            return lastElement
        }
        return nil
    }
    
    func isEmpty() -> Bool {
        if stackArray.count == 0 {
            return true
        }
        return false
    }
}

//MARK:- AGODA HackerRank Test
extension ViewController {
    func reverseWords(inputWords: String) -> String {
        let stringArray = inputWords.components(separatedBy: " ")
        var reverseWords = ""
        
        for word in stringArray.reversed() {
            if stringArray.first == word {
                reverseWords += "\(word)"
            }else {
                reverseWords += "\(word) "
            }
        }
        return reverseWords
    }
    
    
    func getFirstTwoItemsWithoutPair(list: [Int]) -> [Int] {
        var outputArray = [Int]()
        var itemMap = [Int: Int]()
        
        for item in list {
            if let count = itemMap[item] {
                itemMap[item] = count + 1
            } else {
                itemMap[item] = 1
            }
        }
        
        for item in list {
            if let count = itemMap[item], count == 1, outputArray.count < 2 {
                outputArray.append(item)
            }
            
        }
        
        return outputArray
    }
    
    
    func sortDates(dates: [String]) -> [String] {
        var intervalArray = [TimeInterval]()
        var dateSorted = [String]()
        for date in dates {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            if let date = dateFormatter.date(from:date) {
                let timeInterval = date.timeIntervalSince1970
                intervalArray.append(timeInterval)
            }
        }
        
        intervalArray.sort()
        
        for interval in intervalArray {
            let date = NSDate(timeIntervalSince1970: interval)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            
            let myString = formatter.string(from: date as Date)
            dateSorted.append(myString)
            
        }
        return dateSorted
    }
}
