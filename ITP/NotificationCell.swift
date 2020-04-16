//
//  NotificationCell.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 10/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var prioritisation: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
