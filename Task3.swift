//
//  Task3.swift
//  
//
//  Created by Ilya Udovenko on 20/05/2019.
//

import Foundation

func run(command: String, response: @escaping (String) -> Void, responseQueue: DispatchQueue) {
  
}

func run(commands: [String], response: @escaping ([String]) -> Void, responseQueue: DispatchQueue)  {
  let group = DispatchGroup()
  var dic = [Int: String]()
  
  for (index, command) in commands.enumerated() {
    group.enter()
    DispatchQueue.global().async {
      run(command: command, response: { (result) in
        dic[index] = result
        group.leave()
      }, responseQueue: responseQueue)
    }
  }
  group.notify(queue: responseQueue) {
    var result: [String] = []
    for index in 0..<commands.count {
      if let element = dic[index] {
        result.append(element)
      }
    }
    response(result)
  }
}
