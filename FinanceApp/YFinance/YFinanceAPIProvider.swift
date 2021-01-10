//
//  YFinanceAPIProvider.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

fileprivate let basePath = "https://app5m.com.br/iusui1872a5a78512rew/izyway/apiv2/app/"

struct DefaultResponse: Codable {
    let status: String
    let msg: String
}

protocol FinanceProvidable {
    func getFinanceData(completion: @escaping(Result<[ChartEntry], Error>) -> Void)
}

class YFinanceAPIProvider: FinanceProvidable {
    
    lazy var loginPath = "\(basePath)cadastros/login"
    
    func getFinanceData(completion: @escaping(Result<[ChartEntry], Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": "955068e6ccmsh7b50ca4ee486385p1ab17djsn8ee566d54b9b",
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]
        AF.request("https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-charts?symbol=HYDR.ME&interval=5m&range=1d",
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
                    completion(.success(entries))
                case .failure(let error):
                    completion(.failure(error))
                }
            }}
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
