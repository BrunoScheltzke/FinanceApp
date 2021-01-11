//
//  YFinanceModel.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import Foundation

struct ChartWrapper: Decodable {
    let chart: ChartInnerWrapper
}

struct ChartInnerWrapper: Decodable {
    let result: [ChartInfo]
}

struct ChartInfo: Decodable {
    let indicators: Indicator
    let timestamp: [Double]
    let meta: ChartMetadata
}

struct ChartMetadata: Decodable {
    let currency: String
    let symbol: String
}

struct Indicator: Decodable {
    let quote: [Quote]
}

struct Quote: Decodable {
    let low: [Double?]
    let volume: [Double?]
    let close: [Double?]
    let high: [Double?]
    let open: [Double?]
}

struct AutoCompleteWrapper: Decodable {
    let quotes: [SymbolYFinance]
}

struct SymbolYFinance: Decodable {
    let symbol: String
    let longname: String
}
