//
//  Log.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation

public class Log {
    
    init() {
        // do nothing for now
    }
    
    static func d(withMessage message: String) -> Void {
        if message.isEmpty || message == "" {
            return
        }
        
        print("> " + message)
    }
    
    static func e(withErrorMsg errorMsg: String) -> Void {
        if errorMsg.isEmpty || errorMsg == "" {
            return
        }
        
        print("> \tERROR: " + errorMsg)
    }
    
}
