//
//  PagingModel.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

class ModelManager : NSObject {
    var networkRequest : URLSessionTask? = nil
    lazy var objectsArray = [AnyObject]()
    var recentDownloadObjectsArray:[AnyObject]?
}

class PagingModel: ModelManager {
    var page: Int = 1
    var maxPageSize: Int = 10 {
        didSet{
            pageSize = maxPageSize
        }
    }
    var pageSize: Int = 10
    var isMoreItemsPendingToDownload = true
    
    func resetToinitialConfig() {
        networkRequest?.cancel()
        networkRequest = nil
        objectsArray.removeAll(keepingCapacity: false)
        recentDownloadObjectsArray?.removeAll(keepingCapacity: false)
        page = 1
        pageSize = maxPageSize
        isMoreItemsPendingToDownload = true
    }
}

extension PagingModel {
    
    func canDownload() -> Bool {
        return (networkRequest?.state == .completed && isMoreItemsPendingToDownload == true)
    }
    
    func processResponse(_ response : [AnyObject]?) {
        if let array = response , array.count > 0 {
            self.recentDownloadObjectsArray = array
            self.objectsArray += array
            self.configurePaginationValuesForNextRequest()
        } else {
            self.isMoreItemsPendingToDownload = false
        }
    }
    
    func configurePaginationValuesForNextRequest() -> Void {
        if let recent = self.recentDownloadObjectsArray , recent.count < pageSize {
            self.isMoreItemsPendingToDownload = false
        } else {
            self.isMoreItemsPendingToDownload = true
            self.page += 1
            self.maxPageSize = pageSize
        }
        
    }
    
    func refreshResponse(_ response : [AnyObject]?) {
        if let array = response , array.count > 0 {
            self.recentDownloadObjectsArray = array
            self.objectsArray.insert(contentsOf: array, at: 0)
            self.configurePaginationValuesForNextRequest()
        } else {
            self.isMoreItemsPendingToDownload = false
        }
    }
}

