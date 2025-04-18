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
    
    // Private properties
    private var allContacts: [Contact] = []
    var cancellables: Set<AnyCancellable> = []
    
    // Public properties
    @Published var contacts: [Contact] = [.dummy(), .dummy(), .dummy(), .dummy()]
    @Published var searchText: String = ""
    
    // Loading Flags
    @Published var isLoading: Bool = true
    
    var contactsSubject: PassthroughSubject<[Contact], Never> = .init()

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
                
                contactsSubject.send(contacts)
            } catch {
                print(error)
            }
            
            // Delaying ending shimmer effect
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            
            withAnimation {
                isLoading = false
            }
        }
    }
}
