//
//  ViewController.swift
//  ToDoListAdvanced
//
//  Created by 洪立妍 on 1/11/24.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  /*
   [
    index0 : [Todo1, Todo2, Todo3],
    index1 : [Todo4, Todo5, Todo6],
    index2 : [Todo7, Todo8, Todo9]
   ]
   */
  private var todoDict: [String: [Todo]] = TodoStore.shared.readAllAndCategorize()
  
  var sortedCategory: [String] {
    todoDict.keys.sorted { $0 < $1 }
  }
  
  var dataSource: [[Todo]] {
    todoDict.sorted { $0.key < $1.key }.map { $0.value }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    
      _ = UINib(nibName: "HeaderView", bundle: nil)
    
   
    
    print(dataSource)
  }
  
  @IBAction func didTapAddButton(_ sender: Any) {
    
    let alert = UIAlertController(title: "Todo 추가",
                        message: nil, preferredStyle: .alert)
    
    alert.addTextField { textField in
      textField.placeholder = "카테고리 입력"
    }
    
    alert.addTextField { textField in
      textField.placeholder = "할 일 입력"
    }

    let addAction = UIAlertAction(title: "추가", style: .default) { _ in
      
      guard let category = alert.textFields?[0].text,
            !category.isEmpty,
            let description = alert.textFields?[1].text,
            !description.isEmpty
      else {
        return
      }
      
      let todo = Todo(description: description, category: category)
      
      TodoStore.shared.add(todo)
      
      self.todoDict = TodoStore.shared.readAllAndCategorize()
      
      self.tableView.reloadData()
      
      alert.dismiss(animated: true)
    }
    
    let cancelAction = UIAlertAction(title: "삭제", style: .cancel)
    
    alert.addAction(addAction)
    alert.addAction(cancelAction)
    
    self.present(alert, animated: true)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    dataSource.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier, for: indexPath) as? TodoCell else {
      return UITableViewCell()
    }
    
    let todo = dataSource[indexPath.section][indexPath.row]
    
    cell.configure(with: todo)
    cell.delegate = self
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
      if editingStyle == .delete {
        //TODO: Todo 데이터 삭제
        
        let id = dataSource[indexPath.section][indexPath.row].id
        
        TodoStore.shared.delete(todoId: id)
        
        self.todoDict = TodoStore.shared.readAllAndCategorize()
        
        self.tableView.reloadData()
      }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    print(section)
    
    guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView else {
      return nil
    }
    
    headerView.headerTitleLabel.text = sortedCategory[section]
    
    return headerView
  }
}

extension ViewController: TodoCellDelegate {
  func didValueChanged(todoId: Int, isDone: Bool) {
    
    TodoStore.shared.update(todoId: todoId, isDone: isDone)
    
    self.todoDict = TodoStore.shared.readAllAndCategorize()

    self.tableView.reloadData()
  }
}
