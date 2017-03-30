//
//  BaseTableViewCell.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  static func reusableIdentifier() -> String {
    return String(describing: self)
  }
}
