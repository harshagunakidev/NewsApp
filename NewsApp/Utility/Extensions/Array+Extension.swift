//
//  Array+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
