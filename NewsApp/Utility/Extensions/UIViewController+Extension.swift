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
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            if let activityView = self.view.viewWithTag(1000) as? UIActivityIndicatorView { activityView.startAnimating(); return }
            let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            activityView.tag = 1000
            activityView.center = self.view.center
            activityView.hidesWhenStopped = true
            activityView.color = .white
            activityView.startAnimating()
            self.view.addSubview(activityView)
            activityView.bringSubviewToFront(activityView)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let activityView = self.view.viewWithTag(1000) as? UIActivityIndicatorView {
                   activityView.stopAnimating()
               }
        }
    }
    
    func showAlert(title: String = "Error" , message: String , style: UIAlertController.Style = .alert, actions: [UIAlertAction] = []) {
        let alertViewController = UIAlertController(title: title, message: message , preferredStyle: style)
        let oK = UIAlertAction(title: "OK", style: .default)
        alertViewController.addAction(oK)
        DispatchQueue.main.async {
            if !self.isBeingPresented {
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}
