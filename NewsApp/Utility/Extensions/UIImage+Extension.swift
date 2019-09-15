//
//  UIImage+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(urlString: String) {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with:  URL(string: urlString), completed: nil)
    }
}
