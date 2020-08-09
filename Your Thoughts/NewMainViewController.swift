//
//  NewMainViewController.swift
//  Your Thoughts
//
//  Created by Michael Burkhardt on 6/10/20.
//  Copyright © 2020 Noah Evans. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class NewMainViewController: UITableViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var mainWelcomeText: UILabel!
    
    @IBOutlet weak var subWelcomeText: UILabel!
    
    var name: String = ""
    
    let morningTimes = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11]
    let afternoonTimes = [12, 13, 14, 15, 16]
    let eveningTimes = [17, 18, 19, 20, 21, 22, 23]
    
    let morningGreets = ["Got much planned for today?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day!", "Have an amazing day!"]
    let afternoonGreets = ["How are you today?", "How's your day?", "Are you doing well?", "Is your day going well?", "How's things?", "Got much planned for later today?"]
    let eveningGreets = ["How was your day?", "Did you do much today?", "Was today good?", "Did you enjoy your day?"]
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setBG()
        assignBackground()
        
        setupGreeting()
        
        entryBox.returnKeyType = .done
        entryBox.delegate = self
        
    }
    
    
    
    func setupGreeting() {
    
        if morningTimes.contains(hour) {
            mainWelcomeText.text = "Good morning, " + name + "!"
            let greeting:String? = morningGreets.randomElement()
            subWelcomeText.text = greeting
        }
        
        if afternoonTimes.contains(hour) {
            mainWelcomeText.text = "Good afternoon, " + name + "!"
            let greeting:String? = afternoonGreets.randomElement()
            subWelcomeText.text = greeting
        }
        
        if eveningTimes.contains(hour) {
            mainWelcomeText.text = "Good evening, " + name + "!"
            let greeting:String? = eveningGreets.randomElement()
            subWelcomeText.text = greeting
        }
    }
    
    @IBAction func refreshBtn(_ sender: UIBarButtonItem) {
        
        assignBackground()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editingEnded(_ sender: UITextField) {
        // Define blur
            let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
            let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = view.bounds
            
            // Start delete here
            let alertController = UIAlertController(title: "Just to check...", message: "You're about to lose your entry forever.", preferredStyle: .alert)
            
            // Defines the name and type. In this case, its cancel, therefore it will be blue.
            let action2 = UIAlertAction(title: "I'm not done", style: .cancel) { (action:UIAlertAction) in
                blurVisualEffectView.removeFromSuperview()
                // Do nothing.
            }
            
            
            
            // Defines the name and type. In this case, its destructive, therefore it will be red.
            let action1 = UIAlertAction(title: "I'm done", style: .destructive) { (action:UIAlertAction) in
                blurVisualEffectView.removeFromSuperview()
                
                // Calls the text field, then ".text" tells the app that you're talking about the text in the field.
                self.entryBox.text = ""
                
                // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
                self.entryBox.resignFirstResponder()
                
            }
            
            self.view.addSubview(blurVisualEffectView)
            
            // Adds the specefied actions
            alertController.addAction(action1)
            alertController.addAction(action2)
            // Presents the alert
            self.present(alertController, animated: true, completion: nil)
            // End delete here
        
            //entryBox.text = ""
            
            // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
            entryBox.resignFirstResponder()
            //return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
            let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = view.bounds
            
            // Start delete here
            let alertController = UIAlertController(title: "Just to check...", message: "You're about to lose your entry forever.", preferredStyle: .alert)
            
            // Defines the name and type. In this case, its cancel, therefore it will be blue.
            let action2 = UIAlertAction(title: "I'm not done", style: .cancel) { (action:UIAlertAction) in
                blurVisualEffectView.removeFromSuperview()
                // Do nothing.
            }
            
            
            
            // Defines the name and type. In this case, its destructive, therefore it will be red.
            let action1 = UIAlertAction(title: "I'm done", style: .destructive) { (action:UIAlertAction) in
                blurVisualEffectView.removeFromSuperview()
                
                // Calls the text field, then ".text" tells the app that you're talking about the text in the field.
                self.entryBox.text = ""
                
                // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
                self.entryBox.resignFirstResponder()
                
            }
            
            self.view.addSubview(blurVisualEffectView)
            
            // Adds the specefied actions
            alertController.addAction(action1)
            alertController.addAction(action2)
            // Presents the alert
            self.present(alertController, animated: true, completion: nil)
            // End delete here
        
            //entryBox.text = ""
            
            // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
            entryBox.resignFirstResponder()
            return true
    }
    
//    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        guard let key = presses.first?.key else { return }
//
//        switch key.keyCode {
//
//        case .keyboardReturn:
//            //editingEnded()
//            print("return/enter hit")
//        default:
//            super.pressesBegan(presses, with: event)
//        }
//    }
    
    
    func assignBackground() {
        
        let chosenImageNo = Int.random(in: 1 ... 6)
        
        let chosenImageNoStr = String(chosenImageNo)
        
        let backgroundImageID = "bg" + chosenImageNoStr + ".png"
        
        let backgroundImg = UIImageView(image: UIImage(named: backgroundImageID))
        tableView.backgroundView = backgroundImg
        backgroundImg.addBlur()
        
    }
    
    @IBOutlet weak var entryBox: UITextField!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 1.0) { //og 1.5 - also tried out 0.9 at a certain point and that was pretty alright
        // create effect
        let effect = UIBlurEffect(style: .systemMaterial)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

extension UIView: Bluring {}
