//
//  NameVC.swift
//  Your Thoughts
//
//  Created by Noah Evans on 13/08/2020.
//

import Foundation
import UIKit


class NameVC: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    
    let defaults = UserDefaults.standard
    
    func saveName() {
        let name = nameField.text!
        defaults.set(name, forKey: "name")
        print("Saved name \(name)")
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        
        let savedName = defaults.string(forKey: "name")
        if savedName == nil{
            print("Name is not saved")
        }
        else {
            nameField.text = savedName
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveName()
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveName()
        nameField.resignFirstResponder()
        return(true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // Delete name
                defaults.removeObject(forKey: "name")
                print("Removed name")
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
