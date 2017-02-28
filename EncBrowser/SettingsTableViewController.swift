//
//  SettingsTableViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var tView: UITableView!

    let kTitle = "Settings"
    let kDefaultRowHeight: CGFloat = 60
    let kDefaultHeaderHeight: CGFloat = 30
    let data: [String] = ["table", "data", "ya", "yah"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = tView
        self.navigationController?.title = kTitle

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kDefaultRowHeight
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kDefaultHeaderHeight
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        var cell = self.tView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath)

        if (cell != nil) {
            cell.textLabel!.text = self.data[indexPath.row]
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FileTableViewCell")
            cell.textLabel!.text = self.data[indexPath.row]
        }
        */

        let cell = UITableViewCell(style: .default, reuseIdentifier: "FileTableViewCell")
        cell.textLabel!.text = self.data[indexPath.row]

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return kTitle
        default:
            return "misc"
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 0
    }

}

