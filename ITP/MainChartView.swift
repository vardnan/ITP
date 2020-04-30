//
//  MainChartView.swift
//  ITP
//
//  Created by Vardnan Sivarajah on 28/04/2020.
//  Copyright © 2020 Vardnan. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints
import FirebaseAuth
import FirebaseDatabase

class MainChartView: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var graphView: UIView!
    
    @IBOutlet weak var portfolioValue: UILabel!
    
    @IBOutlet weak var feeCode: UILabel!
    
    var uid: String?
    var clientID: String?
    var portValue = " "
    var feeCodeValue = " "
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        chartView.layer.masksToBounds = true
        
        chartView.layer.cornerRadius = 18
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        yAxis.setLabelCount(5, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.setLabelCount(5, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.animate(xAxisDuration: 1.5)
        
        return chartView
    }() 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.center(in: graphView)
        lineChartView.width(to: graphView)
        lineChartView.height(to: graphView)
        
        if clientID == "182969" {
            setDataForYaseen()
        }
        else if clientID == "257862" {
            setDataForLucaClark()
        }
        else if clientID == "538003" {
            setDataForCarlos()
        }
        else if clientID == "569988" {
            setDataForIvan()
        }
        
        graphView.layer.cornerRadius = 20
        graphView.layer.masksToBounds = true
        
        let countRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("initialPortfolioValue")
        
        countRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let portosValue = snapshot.value as? String
            
            self.portValue = portosValue!
            
            self.portfolioValue.text = self.portValue
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        let feeRef =  Database.database().reference(withPath: "users").child(self.uid!).child("clients").child(clientID!).child("feeCode")
        
        feeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let feeValue = snapshot.value as? String
            
            self.feeCodeValue = feeValue!
            
            self.feeCode.text = self.feeCodeValue
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
    }
    




func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    print(entry)
}


func setDataForLucaClark() {
    let set1 = LineChartDataSet(entries: yValues, label: nil)
    
    set1.mode = .cubicBezier
    set1.lineWidth = 2.5
    set1.setColor(.white)
    set1.drawCirclesEnabled = false
    set1.fill = Fill(color: .white)
    set1.fillAlpha = 0.8
    set1.drawFilledEnabled = true
    set1.highlightColor = .systemBlue
    set1.valueTextColor = .systemBlue
    set1.valueFont = .boldSystemFont(ofSize: 9)
    let data = LineChartData(dataSet: set1)
    data.setDrawValues(true)
    lineChartView.data = data
    
}

var yValues: [ChartDataEntry] = [
    ChartDataEntry(x:0, y:80.191),
    ChartDataEntry(x:1, y:80.199),
    ChartDataEntry(x:2, y:80.291),
    ChartDataEntry(x:3, y:80.296),
    ChartDataEntry(x:4, y:80.396),
    ChartDataEntry(x:5, y:80.386),
    
]

func setDataForYaseen() {
    let set1 = LineChartDataSet(entries: yaseenValues, label: nil)
    
    set1.mode = .cubicBezier
    set1.lineWidth = 2.5
    set1.setColor(.white)
    set1.drawCirclesEnabled = false
    set1.fill = Fill(color: .white)
    set1.fillAlpha = 0.8
    set1.drawFilledEnabled = true
    set1.highlightColor = .systemBlue
    set1.valueTextColor = .systemBlue
    set1.valueFont = .boldSystemFont(ofSize: 9)
    let data = LineChartData(dataSet: set1)
    data.setDrawValues(true)
    lineChartView.data = data
    
}

var yaseenValues: [ChartDataEntry] = [
    ChartDataEntry(x:0, y:40.010),
    ChartDataEntry(x:1, y:40.500),
    ChartDataEntry(x:2, y:40.430),
    ChartDataEntry(x:3, y:40.300),
    ChartDataEntry(x:4, y:40.190),
    ChartDataEntry(x:5, y:40.231),
    
]

func setDataForCarlos() {
    let set1 = LineChartDataSet(entries: carlosValues, label: nil)
    
    set1.mode = .cubicBezier
    set1.lineWidth = 2.5
    set1.setColor(.white)
    set1.drawCirclesEnabled = false
    set1.fill = Fill(color: .white)
    set1.fillAlpha = 0.8
    set1.drawFilledEnabled = true
    set1.highlightColor = .systemBlue
    set1.valueTextColor = .systemBlue
    set1.valueFont = .boldSystemFont(ofSize: 9)
    let data = LineChartData(dataSet: set1)
    data.setDrawValues(true)
    lineChartView.data = data
    
}

var carlosValues: [ChartDataEntry] = [
    ChartDataEntry(x:0, y:43.192),
    ChartDataEntry(x:1, y:43.199),
    ChartDataEntry(x:2, y:43.196),
    ChartDataEntry(x:3, y:43.200),
    ChartDataEntry(x:4, y:43.203),
    ChartDataEntry(x:5, y:43.204),
    
]

func setDataForIvan() {
    let set1 = LineChartDataSet(entries: ivanValues, label: nil)
    
    set1.mode = .cubicBezier
    set1.lineWidth = 2.5
    set1.setColor(.white)
    set1.drawCirclesEnabled = false
    set1.fill = Fill(color: .white)
    set1.fillAlpha = 0.8
    set1.drawFilledEnabled = true
    set1.highlightColor = .systemBlue
    set1.valueTextColor = .systemBlue
    set1.valueFont = .boldSystemFont(ofSize: 9)
    let data = LineChartData(dataSet: set1)
    data.setDrawValues(true)
    lineChartView.data = data
    
}

var ivanValues: [ChartDataEntry] = [
    ChartDataEntry(x:0, y:73.817),
    ChartDataEntry(x:1, y:73.816),
    ChartDataEntry(x:2, y:73.819),
    ChartDataEntry(x:3, y:73.910),
    ChartDataEntry(x:4, y:73.990),
    ChartDataEntry(x:5, y:73.899),
    
]

}

