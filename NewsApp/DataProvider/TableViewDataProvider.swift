//
//  TableViewDataProvider.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class TableViewDataProvider<T>: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurator = (T?, UITableViewCell) -> Void
    typealias WillDispalyConfigurator = (T?, UITableViewCell, IndexPath) -> Void
    typealias DidSelectConfigurator = (T?, IndexPath) -> Void

    var models: [T]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    private let cellWillDisplayConfigurator: WillDispalyConfigurator
    private let didSelectConfigurator: DidSelectConfigurator
    
    init(models: [T],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator,  cellWillDisplayConfigurator: @escaping WillDispalyConfigurator,didSelectConfigurator: @escaping DidSelectConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        self.cellWillDisplayConfigurator = cellWillDisplayConfigurator
        self.didSelectConfigurator = didSelectConfigurator

    }
    
    //MARK: UItableView Datasource maethods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[safe: indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        cellConfigurator(model, cell)
        return cell
    }
    
    
    //MARK: UItableView Delegates maethods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[safe: indexPath.row]
        didSelectConfigurator(model, indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 274
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = models[safe: indexPath.row]
        cellWillDisplayConfigurator(model, cell, indexPath)
    }
}
