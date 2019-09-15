//
//  NewsMainCoordinator.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class ArticleMainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ArticleListViewController.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        controller.didClickArticle = {
            [weak self](article) in
            guard let theArticle = article else { return }
            self?.showNewsDetail(theArticle)
        }
        navigationController.pushViewController(controller, animated: true)
    }
}

extension ArticleMainCoordinator {
    
    func showNewsDetail(_ article: Article) {
        let child = ArticleDetailCoordinator(navigationController: navigationController)
        navigationController.setToolbarHidden(true, animated: false)
        child.viewModel = ArticleDetailViewModel.init(article: article)
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child { childCoordinators.remove(at: index); break }
        }
    }
}

