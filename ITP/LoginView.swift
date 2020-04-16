//
//  LoginView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 13/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import LocalAuthentication



class LoginView: UIViewController {
    
    @IBAction func pinCode(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "PinCodeLogin", sender: Any?.self)
        }
        
    }
    
    
    @IBAction func faceID(_ sender: UIButton) {
        
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, error) in
                if good {
                    print("Good")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "FaceID", sender: Any?.self)
                    }
                    
                }
                else {
                    print("Try again")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
}
