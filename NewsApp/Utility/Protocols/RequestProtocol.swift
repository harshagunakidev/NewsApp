//
//  RequestProtocol.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, delete
    var type: String { return self.rawValue.uppercased() }
}

enum ParametersEncoding { case json, url }

public typealias Parameters = [String: Any]

enum Task { case request, requestParameters(Parameters) }

public typealias Headers = [String: String]

protocol RequestProtocol {
    var path: String { get }
    var task: Task { get }
    var method: HTTPMethod { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
