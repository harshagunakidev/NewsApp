//
//  ArticleListViewController.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit



class ArticleListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var viewModel: ArticleListViewModel?
    
    var didClickArticle: ((_ article: Article?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("HEADLINES")
        configureDataSource()
        refreshData()
        showActivityIndicator()
        viewModel?.fetchArticles()
        configurePullToRefresh()
    }
    
    func configureDataSource() {
        let dataSource =  TableViewDataProvider(
            models: [Article](),
            reuseIdentifier: ArticleTableViewCell.identifier,
            
            cellConfigurator: { (article, cell) in
                guard let theCell = cell as? ArticleTableViewCell else { return }
                let artcleCellViewModel = AricleCellViewModel(title: article?.title, date: article?.publishedAt, source: article?.source?.name, imageUrl: article?.urlToImage)
                theCell.configure(viewModel: artcleCellViewModel)
                
        }, cellWillDisplayConfigurator: {[weak self] (article, cell,indexPath) in
            guard let weakSelf = self else { return }
            if  weakSelf.viewModel?.isNextPageAvailable(currentPage: indexPath.row) == true {
                weakSelf.viewModel?.fetchArticles()
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.color = .white
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: UIScreen.main.bounds.width, height: CGFloat(44))
                self?.tableView.tableFooterView = spinner
                self?.tableView.tableFooterView?.isHidden = false
            } else { self?.tableView.tableFooterView?.isHidden = true;  self?.tableView.tableFooterView = nil }
            }, didSelectConfigurator: {[weak self] (article,_) in
                self?.didClickArticle?(article)
        } )
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        viewModel = ArticleListViewModel(dataProvider: dataSource)
    }
    
    func refreshData() {
        viewModel?.reload = {
            [weak self](error) in
            self?.hideActivityIndicator()
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
                self?.tableView.tableFooterView = nil
            }
            if let theError = error {self?.showAlert(message: theError.message) }
        }
    }
    
    func configurePullToRefresh() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .white
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        viewModel?.resetData()
        tableView.reloadData()
        viewModel?.fetchArticles()
    }
}
