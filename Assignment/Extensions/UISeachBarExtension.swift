//
//  UISeachBarExtension.swift
//  Assignment
//
//  Created by Neha Jain on 16/11/24.
//

import UIKit

extension UISearchBar {
    
    //MARK: Setting up searchBar element colors
    func setPlaceholderColor(_ color: UIColor) {
        let textField = self.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = UIColor.white
        textField?.leftView?.tintColor = color
        let placeholder = textField!.value(forKey: "placeholderLabel") as? UILabel
        placeholder?.textColor = color
    }
}
