//
//  EpisodeDetailsViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

final class EpisodeDetailsViewModel {
    
    private let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var title: String {
        return episode.name
    }
    
    var episodeInfo: String {
        return "Season \(episode.season), Episode \(episode.number ?? 0)"
    }
    
    var cleanSummary: String {
        guard let summary = episode.summary else { return "No summary available" }
        return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
    var imageURL: URL? {
        guard let imageURLString = episode.image?.original else { return nil }
        return URL(string: imageURLString)
    }
    
}
