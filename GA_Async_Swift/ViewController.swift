//
//  ViewController.swift
//  GA_Async_Swift
//
//  Created by houjianan on 16/7/27.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gcd()
    }
    
    func gcd() {
//        queue()
//        sync()
//        sync_qSerial()
//        async_qSerial()
//        sync_qConcurrent()
//        async_qConcurrent()
//        async_qConcurrent_groupNotify()
        async_qConcurrent_groupNotifyWait()
//        async_qConcurrent_group_enter_leave_notify()
//        dispatch_block()
//        dispatch_blockWait()
//        dispatch_blockNotify()
//        dispatch_blockCancle()
//        dispatchAfter()
//        dispatchApply()
//        async_barrier_qConcurrent()
//        dispatch_set_targetQ()
    }
    //创建队列
    func queue() {
        //串行队列
        let qSerial = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_SERIAL)
        //并发队列
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        let qMain = dispatch_get_main_queue()
        /*
         public var DISPATCH_QUEUE_PRIORITY_BACKGROUND: dispatch_queue_priority_t { get }
         public var DISPATCH_QUEUE_PRIORITY_DEFAULT: dispatch_queue_priority_t { get }
         public var DISPATCH_QUEUE_PRIORITY_HIGH: dispatch_queue_priority_t { get }
         public var DISPATCH_QUEUE_PRIORITY_LOW: dispatch_queue_priority_t { get }
         */
        let qGloble = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    }
    //同步/异步
    func sync() {
        let qMain = dispatch_get_main_queue()
        let async = dispatch_async(qMain) { 
            
        }
        let sync = dispatch_sync(qMain) { 
            
        }
    }
    //同步串行
    func sync_qSerial() {
        let qSerial = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_SERIAL)
        print("start")
        dispatch_sync(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_sync(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("2")
        }
        dispatch_sync(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_sync(qSerial) {
            print("4")
        }
        print("end")
    }
    //异步串行
    func async_qSerial() {
        let qSerial = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_SERIAL)
        print("start")
        dispatch_async(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_async(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("2")
        }
        dispatch_async(qSerial) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_async(qSerial) {
            print("4")
        }
        print("end")
    }
    
    //同步并行
    func sync_qConcurrent() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        dispatch_sync(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_sync(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("2")
        }
        dispatch_sync(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_sync(qConcurrent) {
            print("4")
        }
        print("end")
    }
    //异步并行
    func async_qConcurrent() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("2")
        }
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_async(qConcurrent) {
            print("4")
        }
        print("end")
    }
    //异步并行群组通知
    func async_qConcurrent_groupNotify() {
        let group = dispatch_group_create()
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(5))
            print("2")
        }
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_group_async(group, qConcurrent) {
            print("4")
        }
        dispatch_group_notify(group, qConcurrent) { 
            print("all end notify")
        }
        print("end")
    }
    //异步并行群组通知等待
    func async_qConcurrent_groupNotifyWait() {
        let group = dispatch_group_create()
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(5))
            print("2")
        }
        dispatch_group_async(group, qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("3")
        }
        dispatch_group_async(group, qConcurrent) {
            print("4")
        }
        //如果在等待的时间内执行完组里面的wait == 0，然后执行下面。
        //如果在等待时间内没有执行完组里的wait != 0，然后执行下面。组里的继续执行。
        let wait = dispatch_group_wait(group, dispatch_time(dispatch_time_t(), Int64(2 * NSEC_PER_SEC)))
        if wait == 0 {
            print("wait = ", wait)
        } else {
            print("wait = ", wait)
        }
        print("end")
    }
    //异步并行通知
    func async_qConcurrent_group_enter_leave_notify() {
        let group = dispatch_group_create()
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        
        dispatch_group_enter(group)
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(1))
            print("1")
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(6))
            print("2")
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("3")
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        dispatch_async(qConcurrent) {
            print("4")
            dispatch_group_leave(group)
        }
        
        dispatch_group_notify(group, qConcurrent) {
            print("all end notify")
        }
        print("end")
    }
    
    func dispatch_block() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        let block = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("基友")
        }
        dispatch_async(qConcurrent, block)
    }
    
    func dispatch_blockWait() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        let block = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("1")
            NSThread.sleepForTimeInterval(NSTimeInterval(4))
            print("2")
        }
        dispatch_async(qConcurrent, block)
        
        let wait = dispatch_block_wait(block, dispatch_time(DISPATCH_TIME_NOW, Int64(3 * NSEC_PER_SEC)))
        if wait == 0 {
            print("wait = ", wait)
        } else {
            print("timeout = ", wait)
        }
    }
    
    func dispatch_blockNotify() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        let block = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("1")
            NSThread.sleepForTimeInterval(NSTimeInterval(4))
            print("2")
        }
        
        let notifyBlock = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("3")
        }
        //        001
        //        dispatch_async(qConcurrent, notifyBlock)
        //        dispatch_block_notify(notifyBlock, qConcurrent, block)
        //        002
        dispatch_async(qConcurrent, block)
        dispatch_block_notify(block, qConcurrent, notifyBlock)
    }
    
    func dispatch_blockCancle() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        let block = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("1")
            NSThread.sleepForTimeInterval(NSTimeInterval(4))
            print("2")
        }
        
        let notifyBlock = dispatch_block_create(dispatch_block_flags_t(0)) {
            print("3")
        }
       
        dispatch_async(qConcurrent, block)
        dispatch_async(qConcurrent, notifyBlock)
        dispatch_block_cancel(notifyBlock)
    }
    
    func dispatchAfter() {
        let qMain = dispatch_get_main_queue()
        
        for i in 0..<5 {
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(i) * NSEC_PER_SEC))
            dispatch_after(time, qMain) {
                print("我已经休息了", i, "秒")
            }
        }
    }

    func dispatchApply() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
//        let qSerial = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_SERIAL)
        dispatch_apply(6, qConcurrent) { (i) in
            print(i)
        }
        print("99")
    }
    
    func async_barrier_qConcurrent() {
        let qConcurrent = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_CONCURRENT)
        print("start")
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(3))
            print("1")
        }
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(6))
            print("2")
        }
        /*
            dispatch_barrier_sync 使用同步 打印结果  start 1 2 4 end 5 3
         */
        dispatch_barrier_async(qConcurrent) {
            print("4")
        }
        dispatch_async(qConcurrent) {
            NSThread.sleepForTimeInterval(NSTimeInterval(2))
            print("3")
        }
        dispatch_async(qConcurrent) {
            print("5")
        }
        print("end")
    }
    
    func dispatch_set_targetQ() {
        let qSerial = dispatch_queue_create("com.ga.ios", DISPATCH_QUEUE_SERIAL)
        let qLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        let qHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        let qDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_set_target_queue(qSerial, qDefault)
        dispatch_async(qSerial) {
            print("1")
        }
        dispatch_async(qLow) {
            print("2")
        }
        dispatch_async(qDefault) {
            print("3")
        }
        dispatch_async(qHigh) {
            print("4")
        }
    }
    


}

