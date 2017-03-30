//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/30/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit

class ContactDetailViewController: UIViewController {
  
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var fullNameLabel: UILabel!
  
  var contact: Contact?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    assert(contact != nil, "Contact should not be nil")
    self.title = "Contact Detail"
    
    fullNameLabel.text = contact?.fullName
    ageLabel.text = String(describing: contact!.age)
    addressLabel.text = contact?.address
    
  }
  
}
