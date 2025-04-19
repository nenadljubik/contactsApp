//
//  ContactsView.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import SwiftUI
import CoreData

struct ContactsView: View {
    @Environment(\.managedObjectContext) private var viewContext
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
                .shimmering(active: viewModel.isLoading && !viewModel.isThereLocalData)
                .redacted(reason: viewModel.isLoading && !viewModel.isThereLocalData ? .placeholder : .init())
                .searchable(text: $viewModel.searchText, prompt: "Search Contacts")
                .refreshable {
                    withAnimation {
                        viewModel.isThereLocalData = false
                        viewModel.isLoading = true
                    }
                    viewModel.fetchContacts()
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if viewModel.isLoading && viewModel.isThereLocalData{
                        Label("Syncing...", systemImage: "arrow.triangle.2.circlepath")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            loadContactsFromCoreData()
            
            viewModel.fetchContacts()
            
            viewModel
                .contactsSubject
                .sink { contacts in
                    saveContactsToCoreData(contacts)
                }
                .store(in: &viewModel.cancellables)
        }
        .appAlert(error: $viewModel.appAlert)
    }
    
    private func saveContactsToCoreData(_ contacts: [Contact]) {
        for contact in contacts {
            guard let contactID = contact.id else {
                print("Contact ID is nil for contact: \(contact.name ?? "Unknown")")
                continue
            }
            
            let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", contactID)
            
            let contactEntity = (try? viewContext.fetch(fetchRequest).first) ?? ContactEntity(context: viewContext)
            contactEntity.id = Int32(contactID)
            contactEntity.name = contact.name
            contactEntity.email = contact.email
            contactEntity.phone = contact.phone
            
            if let company = contact.company, let companyName = company.name {
                let companyFetch: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
                companyFetch.predicate = NSPredicate(format: "name == %@", companyName)
                
                let existingCompany = (try? viewContext.fetch(companyFetch).first)
                let companyEntity = existingCompany ?? CompanyEntity(context: viewContext)
                
                companyEntity.name = company.name
                companyEntity.catchPhrase = company.catchPhrase
                contactEntity.company = companyEntity
            }
            
            if let address = contact.address {
                let addressEntity = AddressEntity(context: viewContext)
                addressEntity.id = UUID()
                addressEntity.street = address.street
                addressEntity.city = address.city
                addressEntity.zipcode = address.zipcode
                contactEntity.address = addressEntity
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save contacts to Core Data: \(error)")
        }
    }
    
    private func loadContactsFromCoreData() {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            let contacts = results.map { Contact(from: $0) }
            
            if !contacts.isEmpty {
                viewModel.contacts = contacts
            }
            viewModel.isThereLocalData = !contacts.isEmpty
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
}

#Preview {
    ContactsView()
}
