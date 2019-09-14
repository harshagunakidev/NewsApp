//
//  Reachability.swift
//  NewsApp
//
//  Created by Harsha on 9/14/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import Foundation
import Network

class Reachability: NSObject {

    var monitor = NWPathMonitor()

    override init() {
        super.init()
        monitor.pathUpdateHandler = {
            path in
        }
        let queue = DispatchQueue.init(label: "monitor queue", qos: .userInitiated)
        monitor.start(queue: queue)
    }

    func isNetworkAvailable() -> Bool {
        return monitor.currentPath.status == .satisfied
    }


}
