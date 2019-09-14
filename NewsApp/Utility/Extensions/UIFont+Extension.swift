//
//  UIFont+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

extension UIFont {
    enum RobotoSlab: String {
        case thin = "robotoslab-thin"
        case bold = "robotoslab-bold"
        case regular = "robotoslab-regular"
        case light = "robotoslab-light"
        
        func size(_ size: CGFloat = 15) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
