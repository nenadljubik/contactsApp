//
//  ContactsAppApp.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import SwiftUI

@main
struct ContactsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContactsView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
