//
//  View + Extensions.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 18.4.25.
//

import Foundation
import SwiftUI

extension View {
    func appAlert(error: Binding<AppAlert?>) -> some View {
        alert(
            error.wrappedValue?.alertTitle ?? "Error",
            isPresented: Binding(
                get: { error.wrappedValue != nil },
                set: { if !$0 { error.wrappedValue = nil } }
            )
        ) {
            Button(error.wrappedValue?.primaryButtonTitle ?? "OK", role: .cancel) {
                error.wrappedValue?.primaryAction?()
                error.wrappedValue = nil
            }
        } message: {
            if let message = error.wrappedValue?.alertDescription {
                Text(message)
            }
        }
    }
}
