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
    private(set) var errorMessage: String = ""
    var networkMonitor = NetworkMonitor()
    
    // Public properties
    @Published var contacts: [Contact] = [.dummy(), .dummy(), .dummy(), .dummy()]
    @Published var searchText: String = ""
    @Published var appAlert: AppAlert?
    @Published var isThereLocalData: Bool = false
    
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
            guard networkMonitor.isConnected else {
                appAlert = .info(title: "No Internet Connection",
                                 message: "No internet connection available. Please check your network connectivity.",
                                 dismissTitle: "OK",
                                 dismissAction: nil)
                
                isLoading = false
                return
            }
            
            do {
                let contacts = try await ContactsService.fetchContacts()
                
                withAnimation {
                    self.allContacts = contacts
                    self.contacts = contacts
                }
                
                contactsSubject.send(contacts)
            } catch {
                appAlert = .info(title: "Oops, something went wrong while fetching the contacts.", message: error.localizedDescription, dismissTitle: "OK", dismissAction: nil)
            }
            
            // Delaying ending shimmer effect
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            
            withAnimation {
                isLoading = false
            }
        }
    }
}
