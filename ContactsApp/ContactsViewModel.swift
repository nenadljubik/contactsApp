//
//  ContactsViewModel.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import Foundation
import SwiftUI
import Combine

class ContactsViewModel: ObservableObject {
    
    private var allContacts: [Contact] = []
    @Published var contacts: [Contact] = []
    @Published var searchText: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchContacts()
        setupBinding()
    }
    
    private func setupBinding() {
        $searchText
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                guard !newValue.isEmpty else {
                    contacts = allContacts
                    return
                }
                
                contacts = allContacts.filter {
                    $0.name?.lowercased().contains(newValue.lowercased()) ?? false
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchContacts() {
        Task { @MainActor in
            do {
                let contacts = try await ContactsService.fetchContacts()
                
                withAnimation {
                    self.allContacts = contacts
                    self.contacts = contacts
                }
            } catch {
                print(error)
            }
        }
    }
}
