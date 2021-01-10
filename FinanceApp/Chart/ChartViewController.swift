//
//  ChartViewController.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import Charts

struct ChartEntry {
    let price: Double
    let dateIndicator: Double
}

class ChartViewController: BaseViewController {

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
        viewModel.delegate = self
        view.lock()
        viewModel.getItens()
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
    
    func didGet(_ items: [ChartEntry]) {
        view.unlock()
        self.entries = items
    }
    
}
