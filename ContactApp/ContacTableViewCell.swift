//
//  ContacTableViewCell.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit
import DataKit

class ContacTableViewCell: BaseTableViewCell {

    @IBOutlet weak var contactAddress: UILabel!
    @IBOutlet weak var contactName: UILabel!

    func configure(withContact contact: Contact) {
      contactName.text = contact.fullName
      contactAddress.text = contact.address
    }

}
