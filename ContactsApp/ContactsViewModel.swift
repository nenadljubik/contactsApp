//
//  ContactsViewModel.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    
    init() {
        fetchContacts()
    }
    
    func fetchContacts() {
        Task { @MainActor in
            do {
                let contacts = try await ContactsService.fetchContacts()
                
                withAnimation {
                    self.contacts = contacts
                }
            } catch {
                print(error)
            }
        }
    }
}
