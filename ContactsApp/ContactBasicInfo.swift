//
//  ContactBasicInfo.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 17.4.25.
//


import UIKit

enum ContactBasicInfo {
    case name(Contact)
    case username(Contact)
    case email(Contact)
    case phone(Contact)
    case address(Contact)
    case company(Contact)
    case website(Contact)
    
    
    var title: String {
        switch self {
        case .name:
            "Name"
        case .username:
            "Username"
        case .email:
            "Email"
        case .phone:
            "Phone"
        case .address:
            "Address"
        case .company:
            "Company"
        case .website:
            "Website"
        }
    }
    
    var value: String {
        switch self {
        case .name(let contact):
            contact.name ?? "-"
        case .username(let contact):
            contact.username ?? "-"
        case .email(let contact):
            contact.email ?? "-"
        case .phone(let contact):
            contact.phone ?? "-"
        case .address(let contact):
            contact.address?.fullAddress ?? "-"
        case .company(let contact):
            String(format: "%@ - %@", contact.company?.name ?? "-", contact.company?.catchPhrase ?? "")
        case .website(let contact):
            contact.website ?? "-"
        }
    }
    
    var image: ImageResource {
        switch self {
        case .name:
                .personIcon
        case .username:
                .usernameIcon
        case .email:
                .mailIcon
        case .phone:
                .phoneIcon
        case .address:
                .pinIcon
        case .company:
                .companyIcon
        case .website:
                .webIcon
        }
    }
}
