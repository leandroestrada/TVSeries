//
//  Endpoint.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    
    var baseURL: String {
        return "https://api.tvmaze.com"
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
