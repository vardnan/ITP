//
//  SettingsView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 14/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MessageUI

class SettingsView: UIViewController {
    
    var uid: String?
    
    
    @IBAction func accountPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func notificationsPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func reportPressed(_ sender: UIButton) {
        
        showMailComposer()
    }
    
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail()
            else {
                return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["vardnan@katapult.vc"])
        composer.setSubject("Issue report")
        composer.setMessageBody("I have an issue with...", isHTML: false)
        
        present(composer, animated: true)
        
    }
    
}

extension SettingsView: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email sent")
            
            controller.dismiss(animated: true)
        }
    }
}
