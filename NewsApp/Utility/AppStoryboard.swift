//
//  AppStoryboard.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewcontrollerClass: T.Type) -> T {
        let storyBoardId =  (viewcontrollerClass as UIViewController.Type).storyboardID
        let controller = instance.instantiateViewController(withIdentifier: storyBoardId) as! T
        return controller
    }
}

extension UIViewController {
    class var storyboardID : String { return "\(self)" }
    
    static func instantiateFromAppStoryBoard(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewcontrollerClass: self)
    }
}
