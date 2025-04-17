//
//  ContactDetailsView.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 17.4.25.
//

import SwiftUI
import Kingfisher

struct ContactDetailsView: View {
    var contact: Contact
    var contactInfo: [ContactBasicInfo]
    @State private var visibleIndices: Set<Int> = []
    
    init(contact: Contact) {
        self.contact = contact
        self.contactInfo = [.name(contact),
                            .username(contact),
                            .email(contact),
                            .phone(contact),
                            .address(contact),
                            .company(contact),
                            .website(contact)
                            
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            contactImage
            
            ForEach(Array(contactInfo.enumerated()), id: \.1.title) { index, info in
                ContactInfoView(contactBasicInfo: info) {
                    handleTap(for: info)
                }
                .opacity(visibleIndices.contains(index) ? 1 : 0)
                .offset(y: visibleIndices.contains(index) ? 0 : 10)
                .animation(.easeOut.delay(Double(index) * 0.05), value: visibleIndices)
            }
            .onAppear {
                for index in contactInfo.indices {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.005) {
                        visibleIndices.insert(index)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    
    var contactImage: some View {
        Group {
            if let image = contact.imageURL,
               let imageURL = URL(string: image)  {
                KFImage(imageURL)
                    .resizable()
            } else {
                Image(.placeholderPerson)
                    .resizable()
                
            }
        }
        .frame(width: 200, height: 200, alignment: .center)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(.black, lineWidth: 2)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 32)
    }
    
    private func handleTap(for contactInfo: ContactBasicInfo) {
        if case .website(contact) = contactInfo,
           let url = contact.website?.asValidURL {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ContactDetailsView(contact: .dummy())
}
