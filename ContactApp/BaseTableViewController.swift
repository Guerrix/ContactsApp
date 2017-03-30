//
//  BaseTableViewController.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView(frame: .zero)
    
  }
}
