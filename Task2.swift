//
//  Task2.swift
//  
//
//  Created by Ilya Udovenko on 20/05/2019.
//

import Foundation

enum DataSource {
  static func acquireNextItem(currentItem: String, completion: @escaping (String) -> Void) {
    queue.async {
      let result = currentItem + "test"
      completion(result)
    }
  }
  
  private static let queue: DispatchQueue = DispatchQueue(label: "com.yandex.test", qos: .default, attributes: .concurrent)
}

final class ThreadSafeString {
  var internalString = ""
  let isolationQueue = DispatchQueue(label: "com.yandex.test2", qos: .default, attributes: .concurrent)
  
  init(_ string: String) {
    isolationQueue.async(flags: .barrier) {
      self.internalString = string
    }
  }
  
  func setString(_ string: String) {
    isolationQueue.async(flags: .barrier) {
      self.internalString = string
    }
  }
  
  func getString() -> String {
    var result = ""
    isolationQueue.sync {
      result = self.internalString
    }
    return result
  }
}

final class Producer {
  var currentItem: ThreadSafeString
  private let queue: DispatchQueue
  
  init() {
    currentItem = ThreadSafeString("")
    queue = DispatchQueue.global()
    scheduleNextRequest()
  }
  
  private func scheduleNextRequest() {
    queue.asyncAfter(deadline: .now() + .seconds(1), execute: onDataRequested)
  }
  
  private func onDataRequested() {
    DataSource.acquireNextItem(currentItem: currentItem.getString()) { [weak self] result in
      guard let self = self else {
        return
      }
      self.currentItem.setString(result)
      self.scheduleNextRequest()
    }
  }
}
