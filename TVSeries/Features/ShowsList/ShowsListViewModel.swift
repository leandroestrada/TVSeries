//
//  ShowsListViewModel.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import Foundation

protocol ShowsListViewModelDelegate: AnyObject {
    func showsListViewModelDidUpdateShows(_ viewModel: ShowsListViewModel)
    func showsListViewModel(_ viewModel: ShowsListViewModel, didFailWithError error: Error)
    func showsListViewModel(_ viewModel: ShowsListViewModel, didSelectShow show: Show)
}

final class ShowsListViewModel {
    
    private let service: TVMazeServiceProtocol
    private var currentPage = 0
    private(set) var shows: [Show] = []
    private(set) var isLoading = false
    private(set) var isSearching = false
    
    weak var delegate: ShowsListViewModelDelegate?
    
    init(service: TVMazeServiceProtocol) {
        self.service = service
    }
    
    func loadNextPage() async {
        guard !isLoading, !isSearching else { return }
        isLoading = true
        
        do {
            let newShows = try await service.fetchShows(page: currentPage)
            if !newShows.isEmpty {
                shows.append(contentsOf: newShows)
                currentPage += 1
                delegate?.showsListViewModelDidUpdateShows(self)
            }
        } catch {
            print("Error loading next page: \(error)")
            delegate?.showsListViewModel(self, didFailWithError: error)
        }
        
        isLoading = false
    }
    
    func searchShows(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        isSearching = true
        
        do {
            let results = try await service.searchShows(query: query)
            shows = results.map { $0.show }
            delegate?.showsListViewModelDidUpdateShows(self)
        } catch {
            print("Error searching shows: \(error)")
            delegate?.showsListViewModel(self, didFailWithError: error)
        }
        
        isLoading = false
    }
    
    func resetSearch() async {
        isSearching = false
        shows = []
        currentPage = 0
        await loadNextPage()
    }
    
    func didSelectShow(at indexPath: IndexPath) {
        let show = shows[indexPath.row]
        delegate?.showsListViewModel(self, didSelectShow: show)
    }
    
}
