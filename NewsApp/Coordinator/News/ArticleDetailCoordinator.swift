//
//  NewsDetailCoordinator.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class ArticleDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var mainCoordinator: ArticleMainCoordinator?
    
    var viewModel: ArticleDetailViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller =
            ArticleDetailViewController.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        controller.viewModel = viewModel
        controller.onClickBack = {
            [weak self] in
            self?.mainCoordinator?.childDidFinish(child: self)
            self?.navigationController.popViewController(animated: true)
            self?.navigationController.navigationBar.isHidden = false

        }
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(controller, animated: true)
    }
}
