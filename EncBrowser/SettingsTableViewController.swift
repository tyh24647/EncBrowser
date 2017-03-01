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
    let kDefaultHeaderHeight: CGFloat = 30
    let dataNames = DataNames.namesList

    // MARK: - VARS
    private var _data: [String]?
    var data: [String]! {
        get {
            return _data ?? [String]()
        } set {
            _data = newValue ?? self._data ?? [String]()
        }
    }

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

        static var size: Int {
            get {
                return 4
            }
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
        
        static var namesList: [String] {
            get {
                return [
                        DataNames.Profile,
                        DataNames.Notifications,
                        DataNames.LockOptions,
                        DataNames.ViewOptions,
                        DataNames.ResetOptions,
                        DataNames.DeleteAllData,
                        DataNames.About
                ]
            }
        }
    }

    // MARK: - OVERRIDE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = kTitle

        Log.d(withMessage: "Initializing table view...")
        self.tableView = tView ?? UITableView(frame: self.view!.frame, style: .plain)
        Log.d(withMessage: "Table view loaded successfully")

        // set table data
        Log.d(withMessage: "Generating table data...")
        data = generateDefaultOptionsData()
        if data == nil {
            Log.e(withErrorMsg: "Unable to generate data for settings table")
            Log.d(withMessage: "Skipping procedure")
            data = [String]()
        }

        // register nib for reuse
        Log.d(withMessage: "Registering cells for reuse with identifier \'\(kReuseIdentifier)\'")
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: kReuseIdentifier)
        Log.d(withMessage: "Settings table view controller loaded successfully")
    }

    fileprivate func generateDefaultOptionsData() -> [String] {
        var tmp = [String]()
        for var name in DataNames.namesList {
            name = name as String!
            tmp.append(name)
        }

        return tmp.count > 0 ? tmp : [String]()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as UITableViewCell?
        if cell != nil {
            var cellName = self.data[indexPath.row]
            cellName = cellName.isEmpty ? "(NULL)" : cellName
            cell?.textLabel!.text = cellName

            switch cellName {
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
        switch section {
        case PrefsSections.userPrefs.rawValue:
            return kUserPrefs
        case PrefsSections.dataPrefs.rawValue:
            return kDataPrefs
        case PrefsSections.other.rawValue:
            return kOtherPrefs
        case PrefsSections.misc.rawValue:
            return kMiscellaneous
        default:
            return nil
        }
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
        switch section {
        case PrefsSections.userPrefs.rawValue:
            return 4
        case PrefsSections.dataPrefs.rawValue:
            return 2
        case PrefsSections.other.rawValue:
            return 1
        case PrefsSections.misc.rawValue:
            return 0
        default:
            return 0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PrefsSections.size
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

