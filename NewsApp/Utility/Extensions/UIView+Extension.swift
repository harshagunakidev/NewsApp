//
//  UIView+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        let colour:UIColor = .black
        gradient.colors = [colour.withAlphaComponent(0.0).cgColor,colour.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
}

