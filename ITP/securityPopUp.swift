//
//  securityPopUp.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 21/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class securityPopUp: UIViewController {

    @IBOutlet weak var securityLabel: UILabel!
    
    @IBOutlet weak var securityCodeLabel: UILabel!
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBAction func closePopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var securityDetail = ""
    var securityCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        securityLabel.text = securityDetail
        securityCodeLabel.text = securityCode
        popUpView.layer.cornerRadius = 10
    }

}
