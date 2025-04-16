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
                if let imageURLString = contact.imageURL,
                   let imageURL = URL(string: imageURLString) {
                    KFImage(imageURL)
                        .resizable()
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.black)
                        }
                        .frame(width: 45, height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                
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
}
