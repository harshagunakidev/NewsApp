//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

class ArticleDetailViewModel {
    private(set) var article: Article?
    
    init(article: Article) {
        self.article = article
    }
}
