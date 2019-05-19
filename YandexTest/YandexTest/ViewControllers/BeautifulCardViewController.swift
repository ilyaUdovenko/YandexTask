//
//  BeautifulCardViewController.swift
//  YandexTest
//
//  Created by Ilya Udovenko on 19/05/2019.
//  Copyright © 2019 Ilya Udovenko. All rights reserved.
//

import UIKit

class BeautifulCardViewController: UIViewController {
  override func loadView() {
    let view = BeautifulCardView()
    self.view = view
  }
}
