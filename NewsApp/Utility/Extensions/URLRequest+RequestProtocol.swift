//
//  URLRequest+RequestProtocol.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

extension URLRequest {
    init(service: RequestProtocol) {
        let components = URLComponents(service: service)
        guard let url = components.url else { preconditionFailure("Failed to construct URL") }
        self.init(url: url)
        httpMethod = service.method.type
        service.headers?.forEach({ addValue($1, forHTTPHeaderField: $0) })
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
