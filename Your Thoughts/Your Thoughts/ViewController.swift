//
//  ViewController.swift
//  Your Thoughts
//
//  Created by Noah Evans on 09/08/2020.
//

import UIKit
import SwiftGifOrigin

class HomeVC: UIViewController {
    
    func setBG() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let chosenImageNo = Int.random(in: 1 ... 6)
        let chosenImageNoStr = String(chosenImageNo)
        let backgroundImageID = "bg" + chosenImageNoStr
        backgroundImage.image = UIImage(named: backgroundImageID)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func loadImage(fileName: String) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: fileName)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
        }
        return nil
    }
    
    func animateImage(imgName: String) {
        imageView.isHidden = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        let toImage = loadImage(fileName: imgName)
        UIView.transition(with: self.imageView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.imageView.image = toImage
        },
                          completion: nil)
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
        greetingText.isHidden = true
        bgButton.isEnabled = false
        settingsButton.isEnabled = false
        textField.isHidden = true
        imageView.loadGif(name: "icon-animated")
        sleep(3)
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


}

