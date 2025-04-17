//
//  ContactInfoView.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 18.4.25.
//

import SwiftUI


struct ContactInfoView: View {
    var contactBasicInfo: ContactBasicInfo
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 8) {
            Image(contactBasicInfo.image)
                .resizable()
                .frame(width: 20, height: 20)
            Text(contactBasicInfo.value)
                .foregroundStyle(.black)
        }
        .onTapGesture {
            onTap?()
        }
    }
}
