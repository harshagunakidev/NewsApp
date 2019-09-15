//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var airticleImageView: UIImageView!
    
    static var identifier = "ArticleTableViewCell"

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientView.applyGradient()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        airticleImageView.image = nil
    }
    
    func configure(viewModel: ArticleRepresentable) {
        titleLabel?.text = viewModel.title
        sourceLabel?.text = viewModel.source
        dateLabel?.text = viewModel.date?.toDate()
        if let urlString = viewModel.imageUrl {
            airticleImageView.loadImage(urlString: urlString)
        }
    }
}
