//
//  AppAlert.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 18.4.25.
//

import Foundation
import SwiftUI

enum AppAlert: LocalizedError, Identifiable {
    case info(title: String, message: String?, dismissTitle: String = "OK", dismissAction: (() -> Void)? = nil)

    var id: String { localizedDescription } // Identifiable for SwiftUI binding

    var alertTitle: String? {
        switch self {
        case .info(let title, _, _, _):
            return title
        }
    }

    var alertDescription: String? {
        switch self {
        case .info(_, let message, _, _):
            return message
        }
    }

    var primaryButtonTitle: String {
        switch self {
        case .info(_, _, let dismissTitle, _):
            return dismissTitle
        }
    }

    var primaryAction: (() -> Void)? {
        switch self {
        case .info(_, _, _, let dismissAction):
            return dismissAction
        }
    }
}
