//
//  NavigationControllerExtention.swift
//  ContactApp
//
//  Created by Jesus Guerra on 3/29/17.
//  Copyright © 2017 Jesus Guerra. All rights reserved.
//

import UIKit

extension UINavigationController {
  func pop(animated: Bool) {
    _ = self.popViewController(animated: animated)
  }
  
  func popToRoot(animated: Bool) {
    _ = self.popToRootViewController(animated: animated)
  }
}
