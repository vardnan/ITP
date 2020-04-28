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

class MainChartView: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var graphView: UIView!
    
    @IBOutlet weak var portfolioValue: UILabel!
    
    var uid: String?
    var clientID: String?
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        chartView.layer.masksToBounds = true
        
        chartView.layer.cornerRadius = 18
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        yAxis.setLabelCount(8, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.setLabelCount(8, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.animate(xAxisDuration: 2.5)
        
        
        
        
        return chartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.center(in: graphView)
        lineChartView.width(to: graphView)
        lineChartView.height(to: graphView)
        setData()
        
        graphView.layer.cornerRadius = 20
        graphView.layer.masksToBounds = true
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
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
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x:0.0, y:10.0),
        ChartDataEntry(x:1.0, y:6.0),
        ChartDataEntry(x:2.0, y:8.0),
        ChartDataEntry(x:3.0, y:6.0),
        ChartDataEntry(x:4.0, y:7.0),
        ChartDataEntry(x:5.0, y:5.0),
        ChartDataEntry(x:6.0, y:12.0),
        ChartDataEntry(x:7.0, y:13.0),
        ChartDataEntry(x:8.0, y:15.0),
        ChartDataEntry(x:9.0, y:17.0),
        ChartDataEntry(x:10.0, y:6.0),
        ChartDataEntry(x:11.0, y:20.0),
        ChartDataEntry(x:12.0, y:10.0),
        ChartDataEntry(x:13.0, y:18.0),
        ChartDataEntry(x:14.0, y:15.0),
        ChartDataEntry(x:15.0, y:33.0),
        ChartDataEntry(x:16.0, y:20.0)
        
    ]
    
}
