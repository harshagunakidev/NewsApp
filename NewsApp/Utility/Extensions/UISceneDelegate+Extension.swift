//
//  AppDelegate+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

extension SceneDelegate {
    func makeNewsListAsRootController(scene: UIWindowScene)  {
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .black
        mainCoordinator = NewsMainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        window?.rootViewController = mainCoordinator?.navigationController
        window?.makeKeyAndVisible()
    }
}
