//
//  Episode.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let number: Int?
    let season: Int
    let summary: String?
    let image: Show.ImageURL?
}
