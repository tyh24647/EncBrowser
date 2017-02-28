//
//  PreviewItem.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit
import QuickLook

class PreviewItem: NSObject, QLPreviewItem {
    
    /*!
     * @abstract The URL of the item to preview.
     * @discussion The URL must be a file URL.
     */
    var filePath: URL?
    
    public var previewItemURL: URL? {
        if let filePath = filePath {
            return filePath
        }
        
        return nil
    }

}
