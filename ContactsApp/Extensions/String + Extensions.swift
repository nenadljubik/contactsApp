//
//  String + Extensions.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 18.4.25.
//

import Foundation

extension String {
    var asValidURL: URL? {
        let prefixed = self.hasPrefix("http") ? self : "https://\(self)"
        return URL(string: prefixed)
    }
}
