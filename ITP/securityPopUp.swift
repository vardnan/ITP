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
    
    var securityDetail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        securityLabel.text = securityDetail
    }

}
