//
//  MarketView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 09/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit

class MarketView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func bloombergTapped(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.bloomberg.com/markets")!
            as URL, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func wsjTapped(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.wsj.com/news/markets")!
            as URL, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func googleFinanceTapped(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.google.com/finance")!
            as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func ftTapped(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.ft.com/markets")!
            as URL, options: [:], completionHandler: nil)
        
        
    }
    
    
    @IBAction func reutersTapped(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.reuters.com/finance/markets")!
            as URL, options: [:], completionHandler: nil)
        
    }
    
}
