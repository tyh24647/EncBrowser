//
//  PreviewTransitionViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit
import QuickLook

class PreviewTransitionViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    let quickLookPreviewController = QLPreviewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.addChildViewController(quickLookPreviewController)
        containerView.addSubview(quickLookPreviewController.view)
        quickLookPreviewController.view.frame = containerView.bounds
        quickLookPreviewController.didMove(toParentViewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
