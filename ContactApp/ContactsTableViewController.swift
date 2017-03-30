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
  
    // Observe Results Notifications
    notificationToken = realm.addNotificationBlock { notification, realm in
      self.updateTable()
    }
    
    self.updateTable()

  }
  
  deinit {
    notificationToken?.stop()
  }
  
  // MARK: - Private Methods
  private func configureTableView() {
    let contacCellNib = UINib(nibName: ContacTableViewCell.reusableIdentifier(), bundle: nil)
    tableView.register(contacCellNib, forCellReuseIdentifier: ContacTableViewCell.reusableIdentifier())
  }
  
  private func updateTable(){
    results = realm.objects(Contact.self)
    tableView.reloadData()
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


