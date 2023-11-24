//
//  ViewController.swift
//  PracticeUI
//
//  Created by 洪立妍 on 11/7/23.
//

import UIKit

struct Family {
    let myName: String
    let bestFriendname: String
    let nextFriendname: String
}

class ViewController: UIViewController {

    let friendNames:[String] = ["Henry","Liyan","Jin"]
    let koreanNames:[String:String] =  ["Henry":"헨리","Liyan":"리엔","Jin":"진"]
    var count: Int = 0
    let friend = Family(myName: "Henry2", bestFriendname: "Liyan2", nextFriendname: "Jin2")
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bestFriendNameLabel: UILabel!
    @IBOutlet weak var nextFriendNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }


    @IBAction func didTapButton(_ sender: Any) {
        nameLabel.text = friend.myName
        bestFriendNameLabel.text = friend.bestFriendname
        nextFriendNameLabel.text = friend.nextFriendname
    }
}

