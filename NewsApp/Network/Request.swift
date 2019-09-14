//
//  Request.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

enum Request: RequestProtocol {
    
    case fetchHeadLines(page: Int, pageSize: Int)

    static var baseURL: String { return "https://newsapi.org" }
    
    var path: String {
        switch self {
        case .fetchHeadLines: return "/v2/top-headlines"
        }
    }
   
    var task: Task {
        var parameters = [String: Any]()
        switch self {
        case .fetchHeadLines(let page, let pageSize):
            parameters["page"] = page
            parameters["pageSize"] = pageSize
            parameters["apiKey"] = NewsApi.key
            return .requestParameters(parameters)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchHeadLines: return .get
        }
    }
    
    var headers: Headers? {
        var headers = Headers()
        headers["Content-Type"] = "application/json"
        switch self {
        case .fetchHeadLines: return headers
        }
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .fetchHeadLines: return .url
        }
    }
}
