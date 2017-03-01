//
//  SettingsTableViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    // MARK: - Linked UI objects
    @IBOutlet weak var tView: UITableView!

    // MARK: - Init constants
    let kTitle = "Settings"
    let kDefaultRowHeight: CGFloat = 60
    let kDefaultHeaderHeight: CGFloat = 30
    let dataNames = DataNames()

    // MARK: - Init vars
    var data: [String]!

    enum SettingsType {
        case Profile
        case Notifications
        case LockOptions
        case ViewOptions
        case ResetOptions
        case DeleteAllData
        case About
    }
    
    struct DataNames {
        static let Profile = "Profile"
        static let Notifications = "Notifications"
        static let LockOptions = "Lock Options"
        static let ViewOptions = "View Options"
        static let ResetOptions = "Reset Options"
        static let DeleteAllData = "Delete All Data"
        static let About = "About"
        
        func getNamesLst() -> [String] {
            var tmp = [String]()
            tmp.append(DataNames.Profile)
            tmp.append(DataNames.Notifications)
            tmp.append(DataNames.LockOptions)
            tmp.append(DataNames.ViewOptions)
            tmp.append(DataNames.ResetOptions)
            tmp.append(DataNames.DeleteAllData)
            tmp.append(DataNames.About)
            return tmp
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = tView
        self.navigationController?.title = kTitle
        self.navigationItem.title = kTitle
        data = generateDefaultOptionsData()
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }

    fileprivate func generateDefaultOptionsData() -> [String] {
        var tmp = [String]()

        for var name in DataNames().getNamesLst() {
            name = name as String!
            tmp.append(name)
        }

        return tmp.count > 0 ? tmp : [String]()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as UITableViewCell?
        if cell != nil {
            cell?.textLabel!.text = self.data[indexPath.row]
            switch self.data[indexPath.row] {
            case DataNames.Profile, DataNames.About, DataNames.Notifications, DataNames.LockOptions:
                cell?.accessoryType = .disclosureIndicator
                break
            case DataNames.ResetOptions, DataNames.DeleteAllData:
                cell?.accessoryType = .detailButton
                break
            default:
                cell?.accessoryType = .none
                break
            }
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FileTableViewCell")
            if cell != nil {
                cell!.textLabel!.text = self.data[indexPath.row]
            }
        }

        return cell ?? UITableViewCell(style: .default, reuseIdentifier: "SettingsCell")
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return kTitle
        default:
            return "misc"
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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

    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

