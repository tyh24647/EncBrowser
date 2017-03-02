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

    static func DEBUG(withMessage message: String) -> Void {
#if DEBUG
        if message.isEmpty || message == "" {
            return
        }

        print("> " + message)
#endif
    }

    static func ERROR(withErrorMsg errorMsg: String) -> Void {
#if DEBUG
        if errorMsg.isEmpty || errorMsg == "" {
            return
        }

        print("> \tERROR: " + errorMsg)
#endif
    }
}
