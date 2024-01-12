//
//  TodoCell.swift
//  ToDoListAdvanced
//
//  Created by 洪立妍 on 1/12/24.
//

import UIKit

protocol TodoCellDelegate: AnyObject {
  func didValueChanged(todoId: Int, isDone: Bool)
}

class TodoCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: TodoCell.self) // "TodoCell"
  
  
    @IBOutlet weak var strikeThroughView: UIView!
  
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
  var todo: Todo?
  weak var delegate: TodoCellDelegate?

  @IBAction func didValueChanged(_ sender: UISwitch) {
    
    guard let id = todo?.id else { return }
    
    delegate?.didValueChanged(todoId: id, isDone: sender.isOn)
    
    print()
  }
  
  func configure(with todo: Todo) {
    self.todo = todo
    titleLabel.text = todo.description
    isDoneSwitch.isOn = todo.isDone
    strikeThroughView.isHidden = !todo.isDone
  }
}

    
    
    
    
    






