//
//  ViewController.swift
//  YandexTest
//
//  Created by Ilya Udovenko on 19/05/2019.
//  Copyright © 2019 Ilya Udovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  weak var beautifulCardViewController: BeautifulCardViewController?
  
  init(beautifulCardViewController: BeautifulCardViewController) {
    self.beautifulCardViewController = beautifulCardViewController
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white

    if let beautifulView = beautifulCardViewController?.view {
      beautifulView.sizeToFit()
      beautifulView.center = view.center
    }
  }


}

