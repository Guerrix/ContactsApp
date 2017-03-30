//
//  ContactsTableViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit
import RealmSwift

class ContactsTableViewController: BaseTableViewController {
  private let realm = try! Realm()
  private var notificationToken: NotificationToken?
  
  fileprivate var results: Results<Contact>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Contacts"

    configureTableView()
    addRealmObservers()
  }
  
  deinit {
    notificationToken?.stop()
  }
  
  // MARK: - Private Methods
  private func configureTableView() {
    let contacCellNib = UINib(nibName: ContacTableViewCell.reusableIdentifier(), bundle: nil)
    tableView.register(contacCellNib, forCellReuseIdentifier: ContacTableViewCell.reusableIdentifier())
  }
  
  
  private func addRealmObservers() {
    results = realm.objects(Contact.self)
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
        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
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
  
 
  
}

// MARK: - Table view data source
extension ContactsTableViewController {
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
    let cell = tableView.dequeueReusableCell(withIdentifier: ContacTableViewCell.reusableIdentifier(), for: indexPath) as! ContacTableViewCell
    let contact = results![indexPath.row]
    cell.configure(withContact: contact)
    return cell
  }
}

// MARK: - Table view Edit
extension ContactsTableViewController {
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      let contact = results![indexPath.row]
      contact.delete()
    }
  }

}



