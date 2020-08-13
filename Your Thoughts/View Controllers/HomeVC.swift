//
//  ViewController.swift
//  Your Thoughts
//
//  Created by Noah Evans on 09/08/2020.
//

import UIKit

class HomeVC: UIViewController, UITextFieldDelegate {
    
    func setBG() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let chosenImageNo = Int.random(in: 1 ... 6)
        let chosenImageNoStr = String(chosenImageNo)
        let backgroundImageID = "bg" + chosenImageNoStr
        backgroundImage.image = UIImage(named: backgroundImageID)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    
    @IBOutlet weak var bgButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var greetingText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let defaults = UserDefaults.standard
    var name: String = ""
    var randomGreet: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(addBlur), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(removeBlur), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        

        // Get current time
        let hour = Calendar.current.component(.hour, from: Date())
        
        // Define times
        let morningTimes = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11]
        let afternoonTimes = [12, 13, 14, 15, 16]
        let eveningTimes = [17, 18, 19, 20, 21, 22, 23]
        
        // Set background
        setBG()
        // Get name
        if let name = defaults.string(forKey: "name") {
        }
        name = "Noah"
        if name == "" {
            // No name
            // Define no name greets
            let morningGreets = ["Got much planned for today?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day!", "Have an amazing day!"]
            let afternoonGreets = ["How are you today?", "How's your day?", "Are you doing well?", "Is your day going well?", "How's things?", "Got much planned for later today?"]
            let eveningGreets = ["How was your day?", "Did you do much today?", "Was today good?", "Did you enjoy your day?"]
            // Check time for random greet
            if morningTimes.contains(hour) {
                // Morning
                randomGreet = morningGreets.randomElement()!
            }
            if afternoonTimes.contains(hour) {
                // Afternoon
                randomGreet = afternoonGreets.randomElement()!
            }
            if eveningTimes.contains(hour) {
                // Evening
                randomGreet = eveningGreets.randomElement()!
            }
            greetingText.text = randomGreet
            navBar.title = "Hey!"
        } else {
            // Name is saved
            // Define name greets
            let morningGreets = ["Got much planned for today, \(name)?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day, \(name).", "Have an amazing day, \(name)."]
            let afternoonGreets = ["How are you today, \(name)?", "How's your day?", "Are you doing well?", "Is your day going well, \(name)?", "How's things?", "Got much planned for later today, \(name)?"]
            let eveningGreets = ["How was your day, \(name)?", "Did you do much today?", "Was today good, \(name)?", "Did you enjoy your day, \(name)?"]
            // Check time for random greet
            if morningTimes.contains(hour) {
                // Morning
                randomGreet = morningGreets.randomElement()!
            }
            if afternoonTimes.contains(hour) {
                // Afternoon
                randomGreet = afternoonGreets.randomElement()!
            }
            if eveningTimes.contains(hour) {
                // Evening
                randomGreet = eveningGreets.randomElement()!
            }
            greetingText.text = randomGreet
            navBar.title = "Hey, \(String(describing: name))!"
        }
    }
    

    
    @objc func addBlur() {
        print("App moved to background")
        // Define blur
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        
        // Add blur
        self.view.addSubview(blurVisualEffectView)
        
    }
    
    @objc func removeBlur() {
        print("App entered")
        // Define blur
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        
        blurVisualEffectView.removeFromSuperview()
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            self.textField.text = ""
            
            // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
            self.textField.resignFirstResponder()
            
        }
        
        self.view.addSubview(blurVisualEffectView)
        
        // Adds the specefied actions
        alertController.addAction(action1)
        alertController.addAction(action2)
        // Presents the alert
        self.present(alertController, animated: true, completion: nil)
        // End delete here
        
        // Remove the "//" in the following lines
        textField.text = ""
        
        // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
        self.textField.resignFirstResponder()
        return true
    }


}

