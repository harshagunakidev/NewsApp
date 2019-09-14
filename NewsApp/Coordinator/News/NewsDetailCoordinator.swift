//
//  NewsDetailCoordinator.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class NewsDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var mainCoordinator: NewsMainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = NewsDetailViewController.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        navigationController.pushViewController(controller, animated: true)
    }
}
