//
//  MyTableViewController.swift
//  PracticeUI
//
//  Created by 洪立妍 on 11/16/23.
//

import UIKit

class MyTableViewController: UIViewController {
   

    @IBOutlet weak var myTableView: UITableView!
    
    let friendNames:[String] = ["Henry","Liyan","Jin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.backgroundColor = .blue
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
}
 
extension MyTableViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendNames.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MyFirstCell" , for: indexPath)
        
        cell.textLabel?.text = friendNames[indexPath.row]
        return cell
    }
    
}
