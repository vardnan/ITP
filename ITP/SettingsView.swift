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

class SettingsView: UIViewController {
    
  var uid: String?
    
 
    @IBAction func accountPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func notificationsPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func reportPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
