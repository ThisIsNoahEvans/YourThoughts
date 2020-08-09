//
//  ViewController.swift
//  Your Thoughts
//
//  Created by Noah Evans on 06/12/2019.
//  Copyright © 2019 Noah Evans. All rights reserved.
//

import UIKit
import WebKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    

    // Code for when any cell in the table view is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Says "ok, if this is section 0 (aka section 1), then do this"
        if indexPath.section == 1 {
            // Says "ok, if this is row 0, then do this"
            if indexPath.row == 0 {
                // Your tweet code
                let items = ["I'm using Your Thoughts to privately share my thoughts. There's no record of what you enter, so there's no need to worry about privacy. It's currently in beta, so you can help to test it here: https://itsnoahevans.co.uk/apps/yourthoughts"]
                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                        if let popoverPresentationController = ac.popoverPresentationController {
                             popoverPresentationController.sourceView = self.view
                            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
                             popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
                        }
                        present(ac, animated: true)
                        }
  

                
        }
        
           if indexPath.section == 2 {
                if indexPath.row == 0 {
                    if let privacyURL = URL(string: "https://velocityapps.tech/yourthoughts/privacy") {
                        UIApplication.shared.open(privacyURL)
                  }
                }
                
                if indexPath.row == 1 {
                    if let privacyURL = URL(string: "https://github.com/VelocityApps/YourThoughts") {
                        UIApplication.shared.open(privacyURL)
      
                }
}
        }
            if indexPath.section == 4 {
                if indexPath.row == 0 {
                   if let betaURL = URL(string: "https://velocityapps.tech/yourthoughts/beta") {
                        UIApplication.shared.open(betaURL)
                }
            }
       }
    
        
       
        



}
}

