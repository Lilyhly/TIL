//
//  ViewController.swift
//  ToDoList보완
//
//  Created by 洪立妍 on 12/22/23.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?

    var todoList: [Todo] = [Todo(id: 0, title: "title1", isCompleted: false),
                            Todo(id: 1, title: "title1", isCompleted: false),
                            Todo(id: 2, title: "title1", isCompleted: false),
                            Todo(id: 3, title: "title1", isCompleted: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.reloadData()
    }

    @IBAction func didTapAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "할 일 추가",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "할 일을 입력하세요"
        }
        let addAction = UIAlertAction(title: "추가",
                                      style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                let newItem = Todo(id: (todoList.last?.id ?? -1) + 1,
                                   title: title,
                                   isCompleted: false)
                todoList.append(newItem)
                self.tableView?.insertRows(at: [IndexPath(row: todoList.count-1, section: 0)], with: .automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        cell.setTask(todoList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
