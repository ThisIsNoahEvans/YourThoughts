//
//  NameViewController.swift
//  Your Thoughts
//
//  Created by Noah Evans on 09/06/2020.
//  Copyright © 2020 Noah Evans. All rights reserved.
//

import Foundation
import UIKit

class NameViewController: UITableViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var name: UITextField!
    
    @IBAction func saveName(_ sender: Any) {
        let userName = name.text
        defaults.set(userName, forKey: "name")
        print("Saved name as \(String(describing: userName))")
    }
    
        
        
    
    
}

