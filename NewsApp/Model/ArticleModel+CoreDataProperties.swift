//
//  ArticleModel+CoreDataProperties.swift
//  
//
//  Created by Harsha on 9/15/19.
//
//

import Foundation
import CoreData


extension ArticleModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleModel> {
        return NSFetchRequest<ArticleModel>(entityName: CoreDataEntity.articles.rawValue)
    }

    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?

}
