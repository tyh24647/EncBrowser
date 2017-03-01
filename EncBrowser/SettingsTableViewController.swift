//
//  SettingsTableViewController.swift
//  EncBrowser
//
//  Created by Tyler hostager on 2/27/17.
//  Copyright © 2017 Tyler Hostager. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var tView: UITableView!

    // MARK: - CONSTANTS
    let kTitle = "Settings"
    let kUserPrefs = "User Preferences"
    let kDataPrefs = "Data Management"
    let kOtherPrefs = "Other"
    let kMiscellaneous = "Misc"
    let kReuseIdentifier = "SettingsCell"
    let kDefaultRowHeight: CGFloat = 60
    let kDefaultHeaderHeight: CGFloat = 20
    let dataNames = DataNames()

    // MARK: - VARS
    var data: [String]!

    // MARK: - ENUMS
    enum SettingsType {
        case profile
        case notifications
        case lockOptions
        case viewOptions
        case resetOptions
        case deleteAllData
        case about
    }

    enum PrefsSections: Int {
        case userPrefs = 0
        case dataPrefs = 1
        case other = 2
        case misc = 3

        init?(rawValue: Int) {
            self.init(rawValue: rawValue)
        }

        static func getSize() -> Int {
            return 4
        }
    }

    // MARK: - STRUCTS
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

    // MARK: - OVERRIDE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.d(withMessage: "Initializing table view...")
        self.tableView = tView
        Log.d(withMessage: "Table view loaded successfully")
        self.navigationController?.title = kTitle
        self.navigationItem.title = kTitle
        Log.d(withMessage: "Generating table data...")
        data = generateDefaultOptionsData()
        if data == nil {
            Log.e(withErrorMsg: "Unable to generate data for settings table")
            Log.d(withMessage: "Skipping procedure")
            data = [String]()
        }

        Log.d(withMessage: "Registering cells for reuse with identifier \(kReuseIdentifier)")
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: kReuseIdentifier)
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
        var cell = self.tView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as UITableViewCell?
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
            Log.e(withErrorMsg: "Could not load UITableViewCell with identifier: '\(kReuseIdentifier)'")
            Log.d(withMessage: "Skipping procedure")
            cell = UITableViewCell(style: .default, reuseIdentifier: "FileTableViewCell")
            if cell != nil {
                cell!.textLabel!.text = self.data[indexPath.row]
            }
        }

        return cell ?? UITableViewCell(style: .default, reuseIdentifier: kReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle = ""

        switch section {
        case PrefsSections.userPrefs.rawValue:
            headerTitle = kUserPrefs
            break
        case PrefsSections.dataPrefs.rawValue:
            headerTitle = kDataPrefs
            break
        case PrefsSections.other.rawValue:
            headerTitle = kOtherPrefs
            break
        case PrefsSections.misc.rawValue:
            headerTitle = kMiscellaneous
            break
        default:
            headerTitle = kMiscellaneous
            break
        }

        return headerTitle
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        switch index {
        case 0, 1, 2, 3:
            return PrefsSections.userPrefs.rawValue
        case 4, 5:
            return PrefsSections.dataPrefs.rawValue
        case 6:
            return PrefsSections.other.rawValue
        default:
            return PrefsSections.misc.rawValue
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0

        switch section {
        case PrefsSections.userPrefs.rawValue:
            numRows = 4
            break
        case PrefsSections.dataPrefs.rawValue:
            numRows = 2
            break
        case PrefsSections.other.rawValue:
            numRows = 1
            break
        case PrefsSections.misc.rawValue:
            numRows = 0
            break
        default:
            break
        }

        return numRows
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PrefsSections.getSize()
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
        return true
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

