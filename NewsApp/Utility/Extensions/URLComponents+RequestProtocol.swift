//
//  URLComponents+RequestProtocol.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

extension URLComponents {
    init(service: RequestProtocol) {
        guard let url = URL(string: Request.baseURL)?.appendingPathComponent(service.path) else { preconditionFailure("Couldn't construct the BaseURL") }
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }
           queryItems = parameters.map({ URLQueryItem(name: $0, value: String(describing: $1)) })
    }
}
