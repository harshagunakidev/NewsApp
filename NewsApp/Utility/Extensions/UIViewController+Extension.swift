//
//  UIViewController+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

extension UIViewController {
   
    func setTitle(_ title:String) {
        let fullTitle = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let titleString = NSAttributedString(string: title as String, attributes: [.font: UIFont.RobotoSlab.bold.size(18) , .foregroundColor: UIColor.white , .paragraphStyle: paragraphStyle, .kern: 1.5])
        fullTitle.append(titleString)
        
        let navTextView = UIView()
        let titleLbl = UILabel()
        titleLbl.attributedText = fullTitle
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.sizeToFit()
        titleLbl.textAlignment = .center
        
        let titleBtn = UIButton.init(frame: titleLbl.frame)
        navTextView.frame = titleLbl.frame
        navTextView.addSubview(titleLbl)
        navTextView.addSubview(titleBtn)
        navigationItem.titleView = nil
        navigationItem.titleView = navTextView
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .black
    }
}
