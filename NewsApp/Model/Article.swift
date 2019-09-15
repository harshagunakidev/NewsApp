//
//  Article.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

// MARK: - Article
class Article: NSObject, Codable {
    var source: Source?
    var author: String?
    var title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
class Source: NSObject, Codable {
    var id: String?
    var name: String?
}
