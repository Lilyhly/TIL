//
//  Todo.swift
//  ToDoListAdvanced
//
//  Created by 洪立妍 on 1/12/24.
//

import Foundation

// Encodable && Decodable
struct Todo: Codable {
  let id: Int
  let description: String
  var isDone: Bool
  let category: String
}

extension Todo {
  init(description: String,
       category: String
  ) {
    self.id = UUID().hashValue
    self.description = description
    self.isDone = false
    self.category = category
  }
}
