//
//  ContactCardView.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import SwiftUI
import Kingfisher

struct ContactCardView: View {
    @State var contact: Contact
    
    var body: some View {
        
        VStack {
            HStack {
                contactImage
                
                VStack(alignment: .leading) {
                    Text(contact.name ?? "-")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                    
                    Text(contact.email ?? "-")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black)
                }
                Spacer()
            }
        }
    }
    
    var contactImage: some View {
        Group {
            if let image = contact.imageURL,
               let imageURL = URL(string: image)  {
                KFImage(imageURL)
                    .resizable()
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.black)
                    }
                
            } else {
                Image(.placeholderPerson)
                    .resizable()
                
            }
        }
        .frame(width: 45, height: 45)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
