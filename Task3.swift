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
  var result: [String] = Array(repeating: "", count: commands.count)
  
  for (index, command) in commands.enumerated() {
    group.enter()
    DispatchQueue.global().async {
      run(command: command, response: { (res) in
        result[index] = res
        group.leave()
      }, responseQueue: responseQueue)
    }
  }
  group.notify(queue: responseQueue) {
    response(result)
  }
}
