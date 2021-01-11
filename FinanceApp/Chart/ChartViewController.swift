//
//  ChartViewController.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import Charts

class ChartViewController: BaseViewController {

    @IBOutlet weak var volumeLabel: SecondaryLabel!
    @IBOutlet weak var lowLabel: SecondaryLabel!
    @IBOutlet weak var highLabel: SecondaryLabel!
    @IBOutlet weak var openLabel: SecondaryLabel!
    @IBOutlet weak var chartView: LineChartView!
    
    var viewModel: ChartViewModel
    var entries = [ChartEntry]() {
        didSet {
            setupEntries()
        }
    }
    
    init(viewModel: ChartViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
        navigationItem.title = viewModel.symbol.symbol
        viewModel.delegate = self
        view.lock()
        viewModel.getItens()
    }
    
    private func setupChart() {
        chartView.xAxis.valueFormatter = DateAxisFormatter()
        chartView.xAxis.labelCount = 6
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelWidth = 20
        chartView.xAxis.labelTextColor = .appWhite
        chartView.leftAxis.labelTextColor = .appWhite
    }
    
    private func setupEntries() {
        let dataEntries: [ChartDataEntry] = entries.map { ChartDataEntry(x: $0.dateIndicator, y: $0.price) }
        let color: UIColor = .green
        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.colors = [color]
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = color.withAlphaComponent(0.3)
        chartView.data = LineChartData(dataSet: dataSet)
        chartView.fitScreen()
    }

}

extension ChartViewController: ChartViewModelDelegate {
    
    func failed(message: String) {
        view.unlock()
        present(message: message)
    }
    
    func didGet(_ item: ([ChartEntry], StockDetail)) {
        view.unlock()
        self.entries = item.0
        openLabel.text = item.1.open
        lowLabel.text = item.1.low
        highLabel.text = item.1.high
        volumeLabel.text = item.1.volume
    }
    
}

class DateAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YY\nhh:mm"
        return formatter.string(from: date)
    }
    
}
