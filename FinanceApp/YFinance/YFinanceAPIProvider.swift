//
//  YFinanceAPIProvider.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

fileprivate let basePath = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/"

struct DefaultResponse: Codable {
    let status: String
    let msg: String
}

enum DateInterval {
    
    case oneDay
    case oneWeek
    case oneMonth
    
    func getDisplayableDate(from timeInterval: TimeInterval) -> Double {
        let date = Date(timeIntervalSince1970: timeInterval)
        let calendar = Calendar.current
        
        switch self {
        case .oneDay: return Double(calendar.component(.hour, from: date)).rounded(toPlaces: 2)
        case .oneWeek: return Double(calendar.component(.day, from: date)).rounded(toPlaces: 2)
        case .oneMonth: return Double(calendar.component(.day, from: date)).rounded(toPlaces: 2)
        }
    }
    
}

class YFinanceAPIProvider: FinanceProvidable {
    
    lazy var historicalDataPath = "\(basePath)market/get-charts?symbol="
    lazy var autocompletePath = "\(basePath)auto-complete?q="
    
    lazy var headers: [String: String] = {
        return [
            "x-rapidapi-key": "955068e6ccmsh7b50ca4ee486385p1ab17djsn8ee566d54b9b",
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]
    }()
    
    func getDateParam(from dateInterval: DateInterval) -> String {
        switch dateInterval {
        case .oneDay: return "1d&range=1d"
        case .oneWeek: return "1w&range=5d"
        case .oneMonth: return "1mo&range=5d"
        }
    }
    
    func searchSymbol(_ symbol: String,
                      completion: @escaping(Result<[Symbol], Error>) -> Void) {
        AF.request("\(autocompletePath)\(symbol)",
                   method: .get,
                   headers: HTTPHeaders(headers))
            .validate()
            .responseJSON { self.handleResponse($0) { (result: Result<AutoCompleteWrapper, Error>) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let item):
                    completion(.success(item.quotes.map { Symbol(symbol: $0.symbol, longname: $0.longname) }))
                }
            }}
    }
    
    func getFinanceData(symbol: String, dateInterval: DateInterval,
                        completion: @escaping(Result<([ChartEntry], StockDetail), Error>) -> Void) {
        AF.request("\(historicalDataPath)\(symbol)&interval=5m&range=1d",
                   method: .get,
                   headers: HTTPHeaders(headers))
            .validate()
            .responseJSON { self.handleResponse($0) { (result: Result<ChartWrapper, Error>) in
                switch result {
                case .success(let chart):
                    guard let points = chart.chart.result.first?.indicators.quote.first?.close,
                          let timestamps = chart.chart.result.first?.timestamp,
                          timestamps.count == points.count else {
                        completion(.failure(CustomError.invalidData))
                        return
                    }
                    var entries = [ChartEntry]()
                    for (index, point) in points.enumerated() {
                        if let point = point {
                            entries.append(ChartEntry(price: point, dateIndicator: timestamps[index]))
                        }
                    }
                    
                    let open = "\(((chart.chart.result.first?.indicators.quote.first?.open.first ?? 0) ?? 0).rounded(toPlaces: 4))"
                    let high = "\(((chart.chart.result.first?.indicators.quote.first?.high.first ?? 0) ?? 0).rounded(toPlaces: 4))"
                    let low = "\(((chart.chart.result.first?.indicators.quote.first?.low.first ?? 0) ?? 0).rounded(toPlaces: 4))"
                    let volume = "\(((chart.chart.result.first?.indicators.quote.first?.volume.first ?? 0) ?? 0).rounded(toPlaces: 4))"
                    let details = StockDetail(open: open, high: high, low: low, volume: volume)
                    
                    completion(.success((entries, details)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }}
    }
    
    func getRiskReturn(stock: String, startDate: Date, endDate: Date, completion: @escaping(Result<String, Error>) -> Void) {
        completion(.failure(CustomError.invalidData))
    }
    
    func performGenericRequest<T: Decodable>(path: String, method: HTTPMethod, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(path)
        .validate()
        .responseJSON { self.handleResponse($0, completion: completion )}
    }
    
    func performGenericRequest<T: Decodable, Parameters: Encodable>(path: String, method: HTTPMethod, parameteres: Parameters? = nil, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(path,
            method: method,
            parameters: parameteres,
            encoder: JSONParameterEncoder.default)
        .validate()
        .responseJSON { self.handleResponse($0, completion: completion )}
    }
    
    private func handleResponse<T: Decodable>(_ response: AFDataResponse<Any>, completion: @escaping(Result<T, Error>) -> Void) {
        switch response.result {
        case .success:
            guard let data = response.data else {
                completion(.failure(CustomError.invalidData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}

enum CustomError: Error {
    case invalidData
    
    var localizedDescription: String {
        get {
            switch self {
            case .invalidData: return Statement.defaultError
            }
        }
    }
}

struct StringError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private var mMsg : String

    init(_ description: String) {
        mMsg = description
    }
}

struct Statement {
    
    static let defaultError = "We are experiencing some issues. Please, try again later."
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
