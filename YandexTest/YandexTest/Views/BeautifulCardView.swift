//
//  BeautifulCardView.swift
//  YandexTest
//
//  Created by Ilya Udovenko on 19/05/2019.
//  Copyright © 2019 Ilya Udovenko. All rights reserved.
//

import UIKit

class BeautifulCardView: UIView {
  override func didMoveToSuperview() {
    backgroundColor = .red
  }
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(width: 100, height: 200)
  }
}
