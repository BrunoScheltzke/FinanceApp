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

class YFinanceAPIProvider {
    
    lazy var loginPath = "\(basePath)cadastros/login"
    
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
            if let resultWapper = try? JSONDecoder().decode([DefaultResponse].self, from: data),
                let defaultResponse = resultWapper.first,
                defaultResponse.status == "02" {
                completion(.failure(StringError(defaultResponse.msg)))
                return
            }
            do {
                // todos os resultados vem dentro de uma array
                let resultWapper = try JSONDecoder().decode([T].self, from: data)
                if let result = resultWapper.first {
                    completion(.success(result))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
            } catch {
                do {
                    // caso o resultado esperado já seja uma array entao o back so retorna a array normal
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    // ao inves de retornar uma array vazia quando nao tem nada, o back retorna uma array com uma model de vazio
                    // entao dar sucesso na completion e retornar uma array vazia do model generico
                    if let result = [] as? T {
                        completion(.success(result))
                    } else {
                        completion(.failure(error))
                    }
                }
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
