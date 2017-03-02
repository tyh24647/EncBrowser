//
// Created by Tyler hostager on 2/28/17.
// Copyright (c) 2017 Tyler Hostager. All rights reserved.
//

import UIKit

class DownloadsTableViewController: UITableViewController {
    @IBOutlet weak var tView: UITableView!

    let kDefaultRowHeight: CGFloat = 60
    let kDefaultHeaderHeight: CGFloat = 20
    let kDownloadCell = "DownloadCell"
    let kFileCell = "FileCell"

    private var _data: [String]?
    var data: [String]! {
        get {
            return _data ?? [String]()
        } set {
            _data = newValue ?? self._data ?? [String]()
        }
    }

    private var _dataTypes: [FileType]!
    var dataTypes: [FileType]! {
        get {
            return _dataTypes ?? [FileType]()
        } set {
            _dataTypes = newValue ?? self.dataTypes ?? [FileType]()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Downloads"
        self.tableView = tView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kDownloadCell, for: indexPath) as UITableViewCell!

        if cell != nil {
            let cellStr = self.data[indexPath.row]



            cell?.textLabel!.text = self.data[indexPath.row]
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: kFileCell, for: indexPath)
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kDefaultRowHeight
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kDefaultHeaderHeight
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        var editingStyle: UITableViewCellEditingStyle

        switch indexPath.row {
        case 0:
            editingStyle = .delete
            break

        /*
        TODO: Add other editing style options
        */

        default:
            editingStyle = .delete
            break
        }

        return editingStyle
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return nil
    }

    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    }

    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
    }

    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }


    override func numberOfSections(`in` tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO open the specified file
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func sectionIndexTitles(`for` tableView: UITableView) -> [String]? {
        return nil
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }


    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        super.performSegue(withIdentifier: identifier, sender: sender)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}
