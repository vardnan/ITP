//
//  KYCCell.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 16/03/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class KYCCell: UITableViewCell {

    @IBOutlet weak var kycLabel: UILabel!
    
    @IBOutlet weak var kycCheckMark: UIImageView!
    
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
