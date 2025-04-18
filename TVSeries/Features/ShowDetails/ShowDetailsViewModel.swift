//
//  ShowDetailsViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

protocol ShowDetailsViewModelDelegate: AnyObject {
    func showDetailsViewModelDidUpdateEpisodes(_ viewModel: ShowDetailsViewModel)
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didFailWithError error: Error)
}

final class ShowDetailsViewModel {
    private let service: TVMazeServiceProtocol
    private(set) var show: Show
    private(set) var episodes: [Int: [Episode]] = [:]
    private(set) var isLoading = false
    
    weak var delegate: ShowDetailsViewModelDelegate?
    
    init(show: Show, service: TVMazeServiceProtocol) {
        self.show = show
        self.service = service
    }
    
    var formattedSchedule: String {
        let days = show.schedule.days.joined(separator: ", ")
        if days.isEmpty || show.schedule.time.isEmpty {
            return "No schedule information"
        }
        return "\(days) at \(show.schedule.time)"
    }
    
    var formattedGenres: String {
        return show.genres.isEmpty ? "No genres available" : show.genres.joined(separator: ", ")
    }
    
    var cleanSummary: String {
        guard let summary = show.summary else { return "No summary available" }
        return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
    func loadEpisodes() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let allEpisodes = try await service.fetchShowEpisodes(id: show.id)
            episodes = Dictionary(grouping: allEpisodes) { $0.season }
            delegate?.showDetailsViewModelDidUpdateEpisodes(self)
        } catch {
            delegate?.showDetailsViewModel(self, didFailWithError: error)
        }
        
        isLoading = false
    }
    
    func numberOfSeasons() -> Int {
        return episodes.keys.count
    }
    
    func season(at index: Int) -> Int {
        let sortedSeasons = episodes.keys.sorted()
        return sortedSeasons[index]
    }
    
    func episodes(for season: Int) -> [Episode] {
        return episodes[season]?.sorted(by: { ($0.number ?? 0) < ($1.number ?? 0) }) ?? []
    }
    
    func episode(at indexPath: IndexPath) -> Episode? {
        let season = season(at: indexPath.section)
        let episodes = episodes(for: season)
        guard indexPath.row < episodes.count else { return nil }
        return episodes[indexPath.row]
    }
    
}
