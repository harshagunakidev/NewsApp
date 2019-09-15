//
//  ArticleModel+CoreDataClass.swift
//  
//
//  Created by Harsha on 9/15/19.
//
//

import Foundation
import CoreData


public class ArticleModel: NSManagedObject {
    static func createEntity() -> ArticleModel? {
        guard let moc = CoreDataManager.sharedInstance.moc else {
            fatalError("Entity Cannot be Create: MOC cannot be nil")
        }
        guard let entityDescription = NSEntityDescription.entity(forEntityName: CoreDataEntity.articles.rawValue, in: moc) else { return nil }
        return NSManagedObject(entity: entityDescription, insertInto: moc) as? ArticleModel
    }
    
    static func save(article: Article) {
      
          guard let moc = CoreDataManager.sharedInstance.moc else { return }
          if let articleModel = ArticleModel.createEntity() {
              articleModel.title = article.title
              articleModel.articleDescription = article.articleDescription
              articleModel.publishedAt = article.publishedAt
              articleModel.sourceName = article.source?.name
              articleModel.urlToImage = article.urlToImage
              
              do {
                  try moc.save()
              } catch {
                print(error.localizedDescription)
              }
          }
      }

}
