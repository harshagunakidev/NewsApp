//
//  Date+Extension.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation


extension String {
    func toDate(formatType: String = "YYYY-MM-dd") -> String?    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        let date = dateFormatter.date(from:self) ?? Date()
        return dateFormatter.string(from: date)
    }
}
