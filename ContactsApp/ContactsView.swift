//
//  ContactsView.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import SwiftUI

struct ContactsView: View {
    @StateObject var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List($viewModel.contacts, id: \.self, editActions: .delete) { $contact in
                    NavigationLink(destination: ContactDetailsView(contact: contact)) {
                        ContactCardView(contact: contact)
                    }
                }
                .animation(.easeInOut, value: viewModel.contacts)
                .searchable(text: $viewModel.searchText, prompt: "Search Contacts")
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactsView()
}
