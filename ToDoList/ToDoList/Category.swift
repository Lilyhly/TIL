//
//  Category.swift
//  ToDoList
//
//  Created by 洪立妍 on 1/9/24.
//

import Foundation

class Category {
    var title: String
    var todos: [String]

    init(title: String, todos: [String] = []) {
        self.title = title
        self.todos = todos
    }
}
