//
//  String+extension.swift
//  ToDoList보완
//
//  Created by 洪立妍 on 12/22/23.
//

import Foundation
import UIKit
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

