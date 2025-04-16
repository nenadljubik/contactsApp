//
//  Router.swift
//  ContactsApp
//
//  Created by Ненад Љубиќ on 16.4.25.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case fetchContacts
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchContacts: return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchContacts: return "/users"
        }
    }
    
    var headers: [String: String] {
        let headers: [String: String] = [
            "Accept": "application/json"
        ]
        
        return headers
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (baseURL + path).asURL()
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        return request
    }
}
