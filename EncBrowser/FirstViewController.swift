//
//  FirstViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let fileBrowser = FileBrowser()
        //self.view = fileBrowser.view
        
        self.navigationItem.title = "My Files"
        
        //self.present(fileBrowser, animated: true, completion: nil)
        //self.present(FileBrowser(initialPath: NSURL(fileURLWithPath: "/") as URL), animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

