//
//  NetworkMonitor.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 18.4.25.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    var isConnected = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
