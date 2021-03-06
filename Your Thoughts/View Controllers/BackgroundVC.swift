//
//  BackgroundVC.swift
//  Your Thoughts
//
//  Created by Noah Evans on 15/08/2020.
//

import UIKit

class BackgroundVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var blurSwitch: UISwitch!
    
    
    let defaults = UserDefaults.standard
    var imgPickCancelled: Bool = false
    var urlToSave: String = ""
    var url: URL!
    var isEmpty: Bool = true
    var fileName: String = ""
    
    let imagePicker = UIImagePickerController()
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let data = pickedImage.pngData() {
                if data.isEmpty {
                    print("Data is empty: no image picked.")
                    urlToSave = "NO_IMAGE_CHOSEN"
                    return
                }
                // Create URL
                    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                
                
                fileName = "user-background.png"
                print("File name: \(fileName)")
                    let url = documents.appendingPathComponent(fileName)
                do {
                        // Write to Disk
                        try data.write(to: url)
                    
                    if imgPickCancelled == true {
                        print("URL is empty: no image")
                        
                        urlToSave = "NO_IMAGE_SPECIFIED"
                    }
                    else if url == nil {
                        print("URL is empty")
                        urlToSave = "NO_IMAGE_SPECIFIED"
                    }
                    else {
                        print("User selected image")
                        urlToSave = fileName
                    }
                    defaults.set(urlToSave, forKey: "custom-background-url")
                    defaults.set(true, forKey: "uploaded-background")

                    defaults.set(0, forKey: "background")
                    defaults.set("NONE", forKey: "colour-background")

                    } catch {
                        print("Unable to Write Data to Disk (\(error))")
                        urlToSave = "NO_IMAGE_CHOSEN"

                        
                        let alert = UIAlertController(title: "Welp, this isn't great.", message: "We were unable to save the image you chose. This could be because you don't have enough storage on your device.", preferredStyle: .alert)

                        let action2 = UIAlertAction(title: "Okay, continue.", style: .destructive) { (action:UIAlertAction) in
                        }

                        let action1 = UIAlertAction(title: "Learn More", style: .default) { (action:UIAlertAction) in
                            let learnAlert = UIAlertController(title: "What went wrong?", message: "We've had an issue saving the image you selected. This can be for a number of reasons, but the most likely one is that your device does not have enough storage free. When you select an image, we make a copy of it from your Photo Library in a place that we can easily get to it when it's needed later. If there isn't enough storage on your device, this can fail. It's also possible that something else happened, but this is unlikely. If you've got more questions, please get in touch.", preferredStyle: .alert)

                            let learnAlertAction = UIAlertAction(title: "Okay!", style: .destructive) { (action:UIAlertAction) in
                                self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }

                            learnAlert.addAction(learnAlertAction)
                            self.present(learnAlert, animated: true)
                        }
                        // Adds the specefied actions
                        alert.addAction(action1)
                        alert.addAction(action2)
                        // Presents the alert
                        self.present(alert, animated: true, completion: nil)
                    }

            }
            
        }
        else {
            print("Data is empty: no image picked.")
            urlToSave = "NO_IMAGE_CHOSEN"
            return
        }
     
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("Image selection was cancelled")
        imgPickCancelled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        let currentBG: Int = defaults.object(forKey: "background") as? Int ?? 0
        guard let customBG = defaults.bool(forKey: "uploaded-background") as? Bool else { let customBG = false }
            
        
        let blurSwitchDefaults = defaults.bool(forKey: "uploaded-background-blur") ?? true
        
        if blurSwitchDefaults == true {
            // Switch is saved as on (or has not been changed so is set to default)
            blurSwitch.isOn = true
            print("Set blur to true")
        }
        if blurSwitchDefaults == false {
            // Switch is saved as off
            blurSwitch.isOn = false
            print("Set blur to true")
        }
        }
    
    @IBAction func blurSwitchChanged(_ sender: Any) {
        if blurSwitch.isOn == true {
            // Switch was changed to On
            defaults.set(true, forKey: "uploaded-background-blur")
            print("Saved blur as true")
        }
        if blurSwitch.isOn == false {
            // Switch was changed to Off
            defaults.set(false, forKey: "uploaded-background-blur")
            print("Saved blur as false")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            // Custom
            if indexPath.row == 1 {
                // Select an image
                
                let imageAlert = UIAlertController(title: "Select an Image", message: "", preferredStyle: .actionSheet)

                let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { [self] (action:UIAlertAction) in
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    present(imagePicker, animated: true, completion: nil)
                }
                
                let camera = UIAlertAction(title: "Camera", style: .default) { [self] (action:UIAlertAction) in
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .camera
                    present(imagePicker, animated: true, completion: nil)
                }
                
                let cancel = UIAlertAction(title: "Camera", style: .cancel)
                
                imageAlert.addAction(photoLibrary)
                imageAlert.addAction(camera)
                imageAlert.addAction(cancel)
                present(imageAlert, animated: true, completion: nil)
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
        }
        if indexPath.section == 3 {
            // Backgrounds
            if indexPath.row == 0 {
                // Leaf
                defaults.set(1, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Leaf")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 4 {
            // Flower 1
            if indexPath.row == 0 {
                defaults.set(2, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Flower 1")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
        if indexPath.section == 5 {
            if indexPath.row == 0 {
                // Flower 2
                defaults.set(3, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Flower 2")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
        if indexPath.section == 6 {
            if indexPath.row == 0 {
                // Durdle Door
                defaults.set(4, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Durdle Door")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
        if indexPath.section == 7 {
            if indexPath.row == 0 {
                // Sunset
                defaults.set(5, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Sunset")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
        if indexPath.section == 8 {
            if indexPath.row == 0 {
                // Bench
                defaults.set(6, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("NONE", forKey: "colour-background")
                
                print("Bench")
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
     // Colours
        
        if indexPath.section == 10 {
            if indexPath.row == 0 {
                // Green
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("green", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 11 {
            if indexPath.row == 0 {
                // Indigo
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("indigo", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 12 {
            if indexPath.row == 0 {
                // Orange
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("orange", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 13 {
            if indexPath.row == 0 {
                // Pink
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("pink", forKey: "colour-background")
                
                tableView.deselectRow(at: indexPath, animated: true)

            }
        }
        if indexPath.section == 14 {
            if indexPath.row == 0 {
                // Purple
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("purple", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 15 {
            if indexPath.row == 0 {
                // Red
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("red", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 16 {
            if indexPath.row == 0 {
                // Teal
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("teal", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 17 {
            if indexPath.row == 0 {
                // Yellow
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("yellow", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 18 {
            if indexPath.row == 0 {
                // Black
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("black", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if indexPath.section == 19 {
            if indexPath.row == 0 {
                // White
                defaults.set(0, forKey: "background")
                defaults.set(false, forKey: "uploaded-background")
                defaults.set("white", forKey: "colour-background")

                tableView.deselectRow(at: indexPath, animated: true)
            }
        }





}
}
