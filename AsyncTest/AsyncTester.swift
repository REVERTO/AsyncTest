//
//  AsyncTester.swift
//  AsyncTest
//
//  Created by Tomoyuki Ito on 2018/01/31.
//  Copyright © 2018 Tomoyuki Ito. All rights reserved.
//

import Foundation
import Promise
import PromiseKit
import BrightFutures
import Hydra

final class AsyncTester {
    
    static func testHydra() {
        var count = 1
        async { _ -> Int in
            
            }.then { value in
        }
    }
    
    static func testGCD() {
        var count = 1
        print(count)
        DispatchQueue.main.async {
            count += 1
            print(count)
            DispatchQueue.main.async {
                count += 1
                print(count)
            }
        }
    }

    static func testOperation() {

        class CountOperation: Operation {
            static var queue = OperationQueue()
            static func start() {
                CountOperation.queue.addOperation(CountOperation())
            }
            var count: Int = 0
            init(count: Int = 0) {
                self.count = count
                super.init()
                self.completionBlock = {
                    if self.count < 3 {
                        CountOperation.queue.addOperation(CountOperation(count: self.count))
                    }
                }
            }
            override func main() {
                super.main()
                count += 1
                print(self.count)
            }
        }
        
        CountOperation.start()
    }
    
}
