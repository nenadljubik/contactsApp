//
//  Address.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//


struct Address: Codable, Hashable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    
    var fullAddress: String {
        return String(format: "%@, %@, %@, %@", street ?? "", suite ?? "", city ?? "", zipcode ?? "")
    }
}
