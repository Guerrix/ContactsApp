//
//  GroupsTableViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit
import RealmSwift

class GroupsTableViewController: BaseTableViewController {
    fileprivate var results: Results<Group>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        addRealmObservers()
    }

    // MARK: - Private Methods
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }


    private func addRealmObservers() {
        results = Group.getAll()
        notificationToken = results?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .top)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .right)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .fade)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.groupDetail{
            let contactsList = segue.destination as! ContactsTableViewController
            if let group = sender as? Group {
                contactsList.group = group
            }
        }
    }

}

// MARK: - Table view data source
extension GroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = self.results {
            return results.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: UITableViewCell.self))
        let group = results![indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "\(group.contacts.count) Contact".appending(group.contacts.count == 1 ? "" : "s")
        cell.accessoryType = .disclosureIndicator
        return cell

    }
}

// MARK: - Table view Edit
extension GroupsTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let group = results![indexPath.row]
            group.delete()
        }
    }
}

// MARK: - Table view delegate
extension GroupsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.groupDetail, sender: results![indexPath.row])
    }
}
