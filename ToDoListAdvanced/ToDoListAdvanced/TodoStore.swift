//
//  TodoStore.swift
//  ToDoListAdvanced
//
//  Created by 洪立妍 on 1/11/24.
//
import Foundation

/*
 앱이 종료되어도 데이터를 유지하려면 메모리가 아닌 저장장치(스마트폰의 경우 플래시 메모리) 에 저장되어야한다.

 저장방법 중 하나 : UserDefaults (요구사항)

 UserDefaults 특징 : key-value 쌍으로 저장할 수 있다.

 공식문서를 보자 : Todo 데이터 타입 은 저장할 수가 없다.
  1. Todo 를 [String: Any] 로 표현하여 배열로 저장
  2. [Todo] 를 JsonDecoder 를 사용하여 Data 를 저장
 */

final class TodoStore {
  
  static var shared: TodoStore = .init()
  
  private let key = "TodoList"
  
  private init() { }
  // CRUD
  
  func readAll() -> [Todo] {
    guard let todoListData = UserDefaults.standard.data(forKey: key),
          let todoList = try? JSONDecoder().decode([Todo].self, from: todoListData)
    else {
      return []
    }
    
    return todoList
  }
  
  func readAllAndCategorize() -> [String: [Todo]] {
    
    let todoList = readAll()
    
    return Dictionary(grouping: todoList) { todo in
      todo.category
    }
  }
  
  func add(_ todo: Todo) {
    
    var todoList = readAll()
    
    todoList.append(todo)
    
    guard let data = try? JSONEncoder().encode(todoList) else {
      return
    }
    
    UserDefaults.standard.setValue(data, forKey: key)
  }
  
  func delete(todoId: Int) {
    
    var todoList = readAll()
    
    todoList.removeAll { todo in
      todo.id == todoId
    }
    
    // 원하는 Todo 가 지워진 상태
    
    guard let data = try? JSONEncoder().encode(todoList) else {
      return
    }
    
    UserDefaults.standard.setValue(data, forKey: key)
  }
  
  func update(todoId: Int, isDone: Bool? = nil) {
    
    var todoList = readAll()
    
    guard let targetIndex = todoList.firstIndex(where: { $0.id == todoId })
    else {
      return
    }

    if let newIsDone = isDone {
      todoList[targetIndex].isDone = newIsDone
    }
    
    // 리스트가 업데이트된 상태
    
    guard let data = try? JSONEncoder().encode(todoList) else {
      return
    }
    
    UserDefaults.standard.setValue(data, forKey: key)
  }
}
