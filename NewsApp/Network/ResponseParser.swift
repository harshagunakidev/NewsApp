//
//  ResponseParser.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

struct APIResponse<T:Codable>: Codable  {
    var status: String?
    var totalResults: Int?
    var code: Int?
    var message: String?
    var data: T?
}

enum APIResult<T> {
    case success(T)
    case error(APIError)
}

