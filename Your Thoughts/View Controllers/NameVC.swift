//
//  NameVC.swift
//  Your Thoughts
//
//  Created by Noah Evans on 13/08/2020.
//

import Foundation
import UIKit

class NameVC: UITableViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let name = nameField.text!
        defaults.setValue(name, forKey: "name")
    }
    
}
