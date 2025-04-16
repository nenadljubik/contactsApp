//
//  ContactsService.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import Foundation
import Alamofire

struct ContactsService {
    static func fetchContacts() async throws -> [Contact] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(Router.fetchContacts)
                .validate()
                .responseDecodable(of: [Contact].self) { response in
                    switch response.result {
                    case .success(let contacts):
                        continuation.resume(returning: contacts)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
