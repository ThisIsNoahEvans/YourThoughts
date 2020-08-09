//
//  MainViewController.swift
//  Your Thoughts
//
//  Created by Dylan McDonald on 12/28/19.
//  Copyright © 2019 Noah Evans. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    
    
    
    
    @IBOutlet weak var entryBox: UITextField!
    
    @IBOutlet weak var welcomeText: UILabel!
    
    @IBOutlet weak var greetText: UILabel!
    
    func setBG() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        // Get random number for image
        let chosenImageNo = Int.random(in: 1 ... 6)
        // Convert to string so can be used to find file name
        let chosenImageNoStr = String(chosenImageNo)
        // Finalise file name
        let backgroundImageID = "bg" + chosenImageNoStr + ".png"
        // Find image and use for background
        backgroundImage.image = UIImage(named: backgroundImageID)
        // Define scale as aspect fill
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        // Display image as background
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG()
        
        self.entryBox.delegate = self
        
        
        
        
        let morningTimes = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11]
        let afternoonTimes = [12, 13, 14, 15, 16]
        let eveningTimes = [17, 18, 19, 20, 21, 22, 23]
        
        let morningGreets = ["Got much planned for today?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day!", "Have an amazing day!"]
        let afternoonGreets = ["How are you today?", "How's your day?", "Are you doing well?", "Is your day going well?", "How's things?", "Got much planned for later today?"]
        let eveningGreets = ["How was your day?", "Did you do much today?", "Was today good?", "Did you enjoy your day?"]
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        if morningTimes.contains(hour) {
            welcomeText.text = "Good morning!"
            let greeting:String? = morningGreets.randomElement()
            greetText.text = greeting
        }
        
        if afternoonTimes.contains(hour) {
            welcomeText.text = "Good afternoon."
            let greeting:String? = afternoonGreets.randomElement()
            greetText.text = greeting
        }
        
        if eveningTimes.contains(hour) {
            welcomeText.text = "Good evening."
            let greeting:String? = eveningGreets.randomElement()
            greetText.text = greeting
            
        
        
        //hide keyboard
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        // Run when the Done button is tapped on any keybaord in this view
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
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
            
            // Remove the "//" in the following lines
            entryBox.text = ""
            
            // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
            self.entryBox.resignFirstResponder()
            return true
        }
        
    }
}

@IBAction func changeBG(_ sender: Any) {
    print("Changing background...")
    setBG()
    print("Changed")
}
}

