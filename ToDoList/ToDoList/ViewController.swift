//
//  ViewController.swift
//  ToDoList
//
//  Created by 洪立妍 on 12/18/23.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        table.isEditing = true

        // Load items from UserDefaults
        if let savedItems = UserDefaults.standard.array(forKey: "items") as? [[String: Any]] {
            items = savedItems
        } else {
            items = []
        }
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new to-do list item!", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter item..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    self?.addItem(title: text, category: "Default")
                    self?.table.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todos = items[section]["todos"] as? [String] {
            return todos.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let todos = items[indexPath.section]["todos"] as? [String] {
            cell.textLabel?.text = todos[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let items = ["Work"]
        return items[section]
      }
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
      }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return items[section]["title"] as? String
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if var todos = items[indexPath.section]["todos"] as? [String] {
                todos.remove(at: indexPath.row)
                items[indexPath.section]["todos"] = todos
                UserDefaults.standard.setValue(items, forKey: "items")
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    
    private func addItem(title: String, category: String) {
        if let categoryIndex = items.firstIndex(where: { $0["title"] as? String == category }) {
            items[categoryIndex]["todos"] = (items[categoryIndex]["todos"] as? [String] ?? []) + [title]
        } else {
            let newCategory = Category(title: category, todos: [title])
            items.append(["category": newCategory])
        }
        UserDefaults.standard.setValue(items, forKey: "items")
    }
    
    
    
    
}
