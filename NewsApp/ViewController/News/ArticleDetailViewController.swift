//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var viewModel: ArticleDetailViewModel?
    
    var onClickBack: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        gradientView.applyGradient()
    }

    
    func configureUI() {
        titleLabel?.text = viewModel?.article?.title
        sourceLabel?.text = viewModel?.article?.source?.name
        dateLabel?.text = viewModel?.article?.publishedAt?.toDate()
        descriptionLabel.text = viewModel?.article?.articleDescription
        if let urlString = viewModel?.article?.urlToImage {
            articleImageView.loadImage(urlString: urlString)
        }
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        onClickBack?()
    }
}
