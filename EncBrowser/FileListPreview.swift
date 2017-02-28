//
//  FileListPreview.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import Foundation
import QuickLook

extension FileListViewController: UIViewControllerPreviewingDelegate {
    func registerFor3DTouch() {
        if #available(iOS 9.0, *) {
            if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                registerForPreviewing(with: self, sourceView: tableView)
            }
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if #available(iOS 9.0, *) {
            if let indexPath = tableView.indexPathForRow(at: location) {
                let selectedFile = fileForIndexPath(indexPath)
                previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
                
                if !selectedFile.isDirectory {
                    return previewManager.previewViewControllerForFile(selectedFile, fromNavigation: false)
                }
            }
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let previewtransitionViewController = viewControllerToCommit as? PreviewTransitionViewController {
            self.navigationController?.pushViewController(previewtransitionViewController, animated: true)
        } else {
            self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
        }
    }
}
