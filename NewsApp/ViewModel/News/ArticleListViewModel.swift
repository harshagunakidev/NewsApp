//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

class ArticleListViewModel: PagingModel {
    private(set) var dataProvider: TableViewDataProvider<Article>
    private var sessionProvider = URLSessionProvider()

    var reload: ((APIError?) -> Void)?
    
    init( dataProvider: TableViewDataProvider<Article>) {
        self.dataProvider = dataProvider
    }
}

extension ArticleListViewModel {
    func fetchArticles() {
        let request = Request.fetchHeadLines(page: page, pageSize: pageSize)
        networkRequest = sessionProvider.request(type: [Article].self, service: request) { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .failure(let error): weakSelf.reload?(error)
            case .success(let data): weakSelf.processResponse(data); weakSelf.dataProvider.models = weakSelf.objectsArray as! [Article]; weakSelf.reload?(nil)
            }
        }
    }
}

extension ArticleListViewModel {
    func isNextPageAvailable(currentPage: Int) -> Bool {
        let article = objectsArray[safe: currentPage] as? Article
        let lastArticle = objectsArray.last as? Article
        if article == lastArticle && canDownload()  {
            return true
        }
        return false
    }
    
    func resetData() {
        resetToinitialConfig()
        dataProvider.models = []
    }
}

class AricleCellViewModel: ArticleRepresentable {
    var title: String?
    var date: String?
    var source: String?
    var imageUrl: String?
    
    init(title: String?, date: String?,source: String?, imageUrl: String?) {
        self.title = title
        self.date = date
        self.source = source
        self.imageUrl = imageUrl
    }
}
