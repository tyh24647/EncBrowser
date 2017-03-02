//
//  WebviewPreviewViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit
import WebKit

class WebviewPreviewViewController: UIViewController {

    // MARK: - Init error enumerations
    enum ParseError: Error {
        case emptySerialization
        case invalidData

        enum Formatting: Error {
            case invalidJSON
            case invalidPLIST
        }

        enum NullObject: Error {
            case jsonData
        }

        enum Serialization: Error {
            case json
            case plist
        }
    }

    // MARK: - Init constants
    let kEmptyJSONObjStr = "{}"
    let kForwardSlashEscapeChar = "\\/"
    let kFormattedSlash = "/"
    let kJSONParseSuccess = "JSON data parsed successfully"
    let kPLISTParseErrMsg = "Unable to parse property list--Invalid PLIST data"
    let kJSONParseErrMsg = "Unable to parse JSON object--Invalid JSON data"
    let kJSONSerializationErrMsg = "Unable to serialize JSON object--data cannot be converted to type 'String'"
    let kPLISTSerializationErrMsg = "Unable to serialize PLIST object--data cannot be converted to type 'String'"
    let kSerializationErrMsg = "Component serialization error--Invalid data"
    let kSkipProcedureDebugMsg = "Skipping procedure"
    let kCannotDisplayFileStr = "The specified filetype cannot be displayed"

    // HTML selector dictionary of parsing conversion values
    let kCharDict = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'"
    ]

    // MARK: - INIT VARIABLES
    var webView = WKWebView()
    var kEmptyJSONObj: Any?

    // file to render
    var file: FBFile? {
        didSet {
            self.title = file?.displayName
            self.processFileForDisplay()
        }
    }

    /// Accesses the Apple 'share' menu to open file in applicable iPhone apps
    func shareFile() -> Void {
        guard let file = file else {
            return
        }

        // set activity options view controller - pulls up appropriate options for filetype
        let activityViewController = UIActivityViewController (
                activityItems: [file.filePath],
                applicationActivities: nil
        )

        self.present(activityViewController,
                animated: true,
                completion: {
                    self.view.layoutIfNeeded()
                }
        )
    }
    
    /// Converts the given data string into an HTML object by injecting the parsed data into an HTML wrapper
    ///
    /// - Parameter convertedStr:   The parsed HTML data String
    private func convertDataToHTML(withDataString convertedStr: String?) -> String! {

        // if data is bad or null, replace with placeholder HTML div to display to the user
        let parsedDataStr = convertedStr ?? String (
                "<div id=placeholder><p>\(self.kCannotDisplayFileStr)</p></div>"
        )

        let htmlStr = String (
                "<html>" +
                "<head>" +
                "<meta charset='utf-8' name='viewport' content='initial-scale=1.0, user-scalable=no'>" +
                "</head>" +
                "<body>" +
                "<pre>\(parsedDataStr)</pre>" +
                "</body>" +
                "</html>"
        )

        return htmlStr
    }

    /// Converts special characters from HTML, XML, etc
    ///
    /// - warning:              May not be the best option for some file types
    /// - parameter string:     String - The string in which to convert
    /// - returns:              The converted string with the proper formatting
    func convertSpecialChars(ofString string: String?) -> String? {
        guard let str = string else {
            return nil
        }

        var tmp = str
        for (escapedChar, unescapedChar) in self.kCharDict {
            tmp = tmp.replacingOccurrences (
                    of: escapedChar,
                    with: unescapedChar,
                    options: NSString.CompareOptions.regularExpression,
                    range: nil
            )
        }

        return tmp
    }

    // Initialize view object after class is constructed
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        self.kEmptyJSONObj = kEmptyJSONObjStr.data(using: .utf8)!

        // Add share button
        let shareBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebviewPreviewViewController.shareFile))
        self.navigationItem.rightBarButtonItem = shareBtn
    }

    /// Parse and display the selected file in the appropriate visual format
    /// inside a UIWebView wrapper instance
    /// 
    /// - warning:  The data to be serialized should not be null. If it is, it will
    ///             show an empty container object in the webview
    func processFileForDisplay() -> Void {
        guard let file = file, let data = try? Data(contentsOf: file.filePath as URL) else { return }
        var rawStr: String!
        
        do {
            switch file.type {
            case .PLIST:
                // MARK: - Serialize PLIST
                guard let plistDesc = try (
                        PropertyListSerialization.propertyList (
                                from: data,
                                options: [],
                                format: nil
                        ) as AnyObject
                ).description as String! else {
                    throw ParseError.Formatting.invalidPLIST
                }
                
                rawStr = plistDesc
                break
            case .JSON:
                guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as Any! else {
                    throw ParseError.Serialization.json
                }

                // MARK: - Serialize JSON
                if JSONSerialization.isValidJSONObject(jsonObj) {
                    guard let JSONData = try JSONSerialization.data (
                            withJSONObject: jsonObj,
                            options: .prettyPrinted
                    ) as Data! else {
                        throw ParseError.invalidData
                    }

                    var jsonStr = String(data: JSONData, encoding: .utf8)

                    // fix parse errors for '/' char after data serialization
                    jsonStr = jsonStr?.replacingOccurrences (
                            of: self.kForwardSlashEscapeChar,
                            with: self.kFormattedSlash
                    )
#if DEBUG
                    if jsonStr != nil {
                        rawStr = jsonStr
                        Log.DEBUG(withMessage: self.kJSONParseSuccess)
                    } else {
                        throw ParseError.emptySerialization
                    }
#else
                    rawStr = jsonStr ?? self.kEmptyJSONObjStr
#endif
                } else {
                    throw ParseError.Formatting.invalidJSON
                    rawStr = self.kEmptyJSONObjStr
                }

                break
            default:
                rawStr = rawStr!.isEmpty ? String(data: data,  encoding: .utf8) : rawStr
                break
            }

            // Load HTML data into web view and display in popup
            if let convertedStr = convertSpecialChars(ofString: rawStr) {
                webView.loadHTMLString(
                        convertDataToHTML(
                                withDataString: convertedStr
                        ),

                        baseURL: nil
                )
            }
        } catch ParseError.Formatting.invalidPLIST {
            Log.ERROR(withErrorMsg: self.kPLISTParseErrMsg)
        } catch ParseError.Formatting.invalidJSON {
            Log.ERROR(withErrorMsg: self.kJSONParseErrMsg)
        } catch ParseError.Serialization.json {
            Log.ERROR(withErrorMsg: self.kJSONSerializationErrMsg)
        } catch ParseError.Serialization.plist {
            Log.ERROR(withErrorMsg: self.kPLISTSerializationErrMsg)
        } catch {
            Log.ERROR(withErrorMsg: self.kSerializationErrMsg)
            Log.DEBUG(withMessage: self.kSkipProcedureDebugMsg)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = self.view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

}
