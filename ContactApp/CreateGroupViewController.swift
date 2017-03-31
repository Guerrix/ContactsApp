//
//  CreateGroupViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/30/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit
import RealmSwift

class CreateGroupViewController: BaseViewController {


    fileprivate var results: Results<Contact>?
    fileprivate var selectedContacts = [Contact]()


    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reloadData()

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CreateGroupViewController.saveGroup))
        navigationItem.rightBarButtonItem = saveButton
    }

    func saveGroup() {

        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error",
                                          message: "Set Group Name",
                                          preferredStyle: UIAlertControllerStyle.alert)

            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)

            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }

        let group = Group()
        group.name = nameTextField.text!
        group.contacts.append(objectsIn: selectedContacts)
        group.saveOrUpdate()
        navigationController?.pop(animated: true)
    }

    // MARK: - Private Methods
    private func configureTableView() {
        contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        contactsTableView.tableFooterView = UIView(frame: .zero)
    }

    private func reloadData() {
        results = Contact.getAllWithoutGroup()
        contactsTableView.reloadData()
    }


}

// MARK: - Table view data source
extension CreateGroupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = self.results {
            return results.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        let contact = results![indexPath.row]
        cell.textLabel?.text = contact.fullName
        cell.accessoryType = .none;
        if selectedContacts.contains(contact) {
            cell.accessoryType = .checkmark;
        }
        return cell
    }
}

// MARK: - Table view delegate
extension CreateGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = results![indexPath.row]
        if selectedContacts.contains(contact) {
            if let index = selectedContacts.index(of: contact) {
                selectedContacts.remove(at: index)
            }
        } else {
            selectedContacts.append(contact)
        }

        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
