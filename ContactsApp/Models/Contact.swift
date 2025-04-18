//
//  Contact.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import Foundation

struct Contact: Codable, Hashable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    var imageURL: String? {
        guard let id = id else { return nil }
        return "https://i.pravatar.cc/150?img=\(id)"
    }
}

extension Contact {
    init(from entity: ContactEntity) {
        self.id = Int(entity.id)
        self.name = entity.name
        self.username = entity.username
        self.website = entity.website
        self.email = entity.email
        self.phone = entity.phone
        self.company = entity.company.map { Company(name: $0.name, catchPhrase: $0.catchPhrase) }
        self.address = entity.address.map {
            Address(
                street: $0.street,
                suite: $0.suite,
                city: $0.city,
                zipcode: $0.zipcode
            )
        }
    }
}

extension Contact {
    static func dummy() -> Contact {
        return .init(id: Int.random(in: 0...10),
                     name: "John Doe",
                     username: "johnDoe",
                     email: "johnDoe@example.com",
                     address: nil,
                     phone: "+389112233",
                     website: "www.google.com",
                     company: nil)
    }
}
