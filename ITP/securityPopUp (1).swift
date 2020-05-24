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
    
    @IBOutlet weak var securityCode: UILabel!
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBAction func closePopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var securityDetail = ""
    var securityNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        securityLabel.text = securityDetail
        securityCode.text = securityNumber
        popUpView.layer.cornerRadius = 10
    }
}
