//
//  Show.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

struct Show: Codable {
    let id: Int
    let name: String
    let summary: String?
    let genres: [String]
    let schedule: Schedule
    let image: ImageURL?
    
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
    
    struct ImageURL: Codable {
        let medium: String?
        let original: String?
    }
}

struct ShowSearchResult: Codable {
    let show: Show
    let score: Double
}
