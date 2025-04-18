//
//  TVMazeEndpoint.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

enum TVMazeEndpoint: Endpoint {
    case shows(page: Int)
    case searchShows(query: String)
    case showDetails(id: Int)
    case showEpisodes(id: Int)
    case searchPeople(query: String)
    case personDetails(id: Int)
    
    var path: String {
        switch self {
        case .shows:
            return "/shows"
        case .searchShows:
            return "/search/shows"
        case .showDetails(let id):
            return "/shows/\(id)"
        case .showEpisodes(let id):
            return "/shows/\(id)/episodes"
        case .searchPeople:
            return "/search/people"
        case .personDetails(let id):
            return "/people/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .shows(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        case .searchShows(let query):
            return [URLQueryItem(name: "q", value: query)]
        case .searchPeople(let query):
            return [URLQueryItem(name: "q", value: query)]
        default:
            return nil
        }
    }
}
