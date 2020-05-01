//
//  PortfolioCompositionView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 29/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import Charts
import FirebaseAuth
import FirebaseDatabase

class PortfolioCompositionView: UIViewController {
    
    @IBOutlet weak var portfolioValueLabel: UILabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var stepperOne: UIStepper!
    @IBOutlet weak var stepperTwo: UIStepper!
    @IBOutlet weak var stepperThree: UIStepper!
    
    var uid: String?
    
    var clientID: String?
    
    var firstDataEntry = PieChartDataEntry(value: 0)
    var secondDataEntry = PieChartDataEntry(value: 0)
    var thirdDataEntry = PieChartDataEntry(value: 0)
    
    var portfolioValue = "1"
    
    var initialPortValue = "1"
    
    var dataArray = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.portfolioValueLabel.text = String(self.portfolioValue)
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("initialPortfolioValue")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let portosValue = snapshot.value as? String
            
            self.initialPortValue =    portosValue!
            
            self.portfolioValue = portosValue!
            
            self.portfolioValueLabel.text = String(self.portfolioValue)
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        stepperOne.layer.cornerRadius = 5
        stepperTwo.layer.cornerRadius = 5
        stepperThree.layer.cornerRadius = 5
        pieChart.chartDescription?.text = ""
        firstDataEntry.value = stepperOne.value
        firstDataEntry.label = "Equities"
        secondDataEntry.value = stepperTwo.value
        secondDataEntry.label = "Bonds"
        thirdDataEntry.value = stepperThree.value
        thirdDataEntry.label = "Derivatives"
        pieChart.layer.backgroundColor = #colorLiteral(red: 0.1976897717, green: 0.2136173248, blue: 0.2418804765, alpha: 1)
        pieChart.animate(xAxisDuration: 2.5)
        
        dataArray = [firstDataEntry, secondDataEntry, thirdDataEntry]
        
        updateChartData()
        
    }
    
    @IBAction func stepperOnePressed(_ sender: UIStepper) {
        let step1Value = sender.value
        firstDataEntry.value = sender.value
        self.portfolioValueLabel.text = String(Int(self.portfolioValue)! + Int(step1Value*700))
        
        updateChartData()
    }
    
    @IBAction func stepperTwoPressed(_ sender: UIStepper) {
        secondDataEntry.value = sender.value
        let step1Value = sender.value
        self.portfolioValueLabel.text = String(Int(self.portfolioValue)! + Int(step1Value*400))
        updateChartData()
    }
    
    @IBAction func stepperThreePressed(_ sender: UIStepper) {
        thirdDataEntry.value = sender.value
        let step1Value = sender.value
        self.portfolioValueLabel.text = String(Int(self.portfolioValue)! + Int(step1Value*200))
        updateChartData()
    }
    
    @IBAction func resetChartValue(_ sender: Any) {
        resetChart()
    }
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(entries: dataArray, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [#colorLiteral(red: 0.07058823529, green: 0.3843137255, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.3647058824, blue: 0.3568627451, alpha: 1), #colorLiteral(red: 1, green: 0.6470588235, blue: 0.2117647059, alpha: 1)]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    func resetChart() {
        stepperOne.value = 8
        stepperTwo.value = 4
        stepperThree.value = 1
        
        firstDataEntry.value = stepperOne.value
        secondDataEntry.value = stepperTwo.value
        thirdDataEntry.value = stepperThree.value
        
        self.portfolioValueLabel.text = String(initialPortValue)
        
        updateChartData()
    }
    
}
