//
//  PinCode.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 13/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class PinCode: UIViewController {
    
    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var popUpView: UIView!
    
   
    @IBOutlet weak var pinCodeText: UITextField!
    
    @IBAction func pinContinue(_ sender: UIButton) {
        if pinCodeText.text == "2855" {
            self.performSegue(withIdentifier: "PinCodeToLogin", sender: Any?.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        popUpView.layer.cornerRadius = 10
    }
    
}
