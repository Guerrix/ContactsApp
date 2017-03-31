//
//  AddContactViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit

class AddContactViewController: BaseViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AddContactViewController.saveContact))
        navigationItem.rightBarButtonItem = saveButton
    }

    func saveContact() {

        if allFieldsValid() {
            let newContact = Contact()
            newContact.firstName = firstNameTextField.text!
            newContact.lastName = lastNameTextField.text!
            if let age = Int(ageTextField.text!) {
                newContact.age = age
            }
            newContact.address = addressTextField.text!

            newContact.saveOrUpdate()
            navigationController?.pop(animated: true)
        }


    }

    private func allFieldsValid() -> Bool {

        var allGood = true
        //Just a basic validation but we can be as detailed as possible
        if firstNameTextField.text!.isEmpty ||
            lastNameTextField.text!.isEmpty ||
            ageTextField.text!.isEmpty ||
            addressTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error",
                                          message: "All data is mandatory",
                                          preferredStyle: UIAlertControllerStyle.alert)

            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)

            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            allGood = false
        }

        return allGood
    }



}
