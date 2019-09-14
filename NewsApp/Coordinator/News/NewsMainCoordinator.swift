//
//  NewsMainCoordinator.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class NewsMainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = NewsListViewController.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension NewsMainCoordinator {
    
    func showNewsDetail() {
        let child = NewsDetailCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child { childCoordinators.remove(at: index); break }
        }
    }
}

