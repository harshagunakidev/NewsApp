//
//  URLSessionProvider.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

final class URLSessionProvider: RequestProviderProtocol {
    
    private var session: URLSessionProtocol
    static var timoutInterval = 60.0
    
    var reachabilty = Reachability()
    
    static var defaultSessionConfiguration : URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = URLSessionProvider.timoutInterval
        configuration.timeoutIntervalForResource = URLSessionProvider.timoutInterval
        configuration.requestCachePolicy = .useProtocolCachePolicy
        if #available(iOS 11.0, *) { configuration.waitsForConnectivity = true }
        configuration.isDiscretionary = true
        configuration.httpCookieAcceptPolicy = .always
        return configuration
    }()
    
    init(session: URLSessionProtocol = URLSession(configuration: URLSessionProvider.defaultSessionConfiguration)) {
        self.session = session
    }
    
    func request<T: Codable>(type: T.Type, service: RequestProtocol, completion: @escaping ((NetworkReponse<T>) -> Void)) -> URLSessionTask? {
        let request = URLRequest(service: service)
        guard reachabilty.isNetworkAvailable() else {
            completion(.failure(.init(type: .clientError(.noInternetConnection))))
            return nil
        }
        let task = session.dataTask(request: request) { [weak self] (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            self?.parseData(data: data, response: httpResponse, error: error, completion: completion)
        }
        task.resume()
        return task
    }
    
    fileprivate func parseData<T: Codable>(data: Data?, response: HTTPURLResponse?,error: Error?, completion: (NetworkReponse<T>) -> Void) {
        guard error == nil else { return completion(.failure(.init(type: .serverError(.unknownError)))) }
        guard let httpResponse = response else { return completion(.failure(.init(type: .clientError(.nilResponse)))) }
        guard let theData = data else { return completion(.failure(.init(type: .clientError(.insufficientData)))) }
        
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200..<300:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try? decoder.decode(APIResponse<T>.self, from: theData)
            
            guard let theModel = model, let status = theModel.status else  { return completion(.failure(.init(type: .clientError(.insufficientData)))) }
            if let modelData = theModel.articles, status == "ok" {
                completion(.success(modelData))
            } else {
                completion(.failure(.init(type: .serverError(.unknownError))))
            }
            
        case 400:
            completion(.failure(.init(type: .serverError(.badRequest), code: statusCode )))
        case 401:
            completion(.failure(.init(type: .serverError(.unauthorized), code: statusCode)))
        case 403:
            completion(.failure(.init(type: .serverError(.forbidden), code: statusCode)))
        case 404:
            completion(.failure(.init(type: .serverError(.notFound), code: statusCode)))
        case 500:
            completion(.failure(.init(type: .serverError(.internalServerError), code: statusCode)))
        case 501:
            completion(.failure(.init(type: .serverError(.notImplemented), code: statusCode)))
        case 502:
            completion(.failure(.init(type: .serverError(.badGateway), code: statusCode)))
        case 503:
            completion(.failure(.init(type: .serverError(.serviceUnavailable), code: statusCode)))
        case 504:
            completion(.failure(.init(type: .serverError(.gatewayTimeout), code: statusCode)))
        default:
            completion(.failure(.init(type: .serverError(.unknownError), code: statusCode)))
        }
    }
}
