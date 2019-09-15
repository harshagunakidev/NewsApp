//
//  Article.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation
import CoreData

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
    
    
    static func fetchArticlesFromDB() -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.articles.rawValue)
        var articlesModels: [ArticleModel]?
        var articles = [Article]()
        do {
            articlesModels = try CoreDataManager.sharedInstance.moc?.fetch(fetchRequest) as? [ArticleModel]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        _  = articlesModels?.map { (articleModel) -> ArticleModel in
            let article = Article()
            article.title = articleModel.title
            article.articleDescription = articleModel.articleDescription
            let source = Source()
            source.name = articleModel.sourceName
            article.source = source
            article.urlToImage = articleModel.urlToImage
            article.publishedAt = articleModel.publishedAt
            articles.append(article)
            return articleModel
        }
        return articles
    }
}

// MARK: - Source
class Source: NSObject, Codable {
    var id: String?
    var name: String?
}
