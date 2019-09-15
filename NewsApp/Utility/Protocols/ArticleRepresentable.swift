//
//  ArticleRepresentable.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

protocol ArticleRepresentable {
    var title: String? { get }
    var date: String? { get }
    var source: String? { get }
    var imageUrl: String? { get }
}
