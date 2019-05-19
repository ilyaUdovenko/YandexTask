//
//  UIViewController+Extension.swift
//  YandexTest
//
//  Created by Ilya Udovenko on 19/05/2019.
//  Copyright © 2019 Ilya Udovenko. All rights reserved.
//

import UIKit

extension UIViewController {
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  func remove() {
    guard parent != nil else {
      return
    }
    
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}
