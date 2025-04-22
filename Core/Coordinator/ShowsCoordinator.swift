extension ShowsCoordinator: ShowsListViewModelDelegate {
    func showsListViewModel(_ viewModel: ShowsListViewModel, didSelectShow show: Show) {
        print("DEBUG: ShowsCoordinator - show selected: \(show.name)")
        showShowDetails(show)
    }
}

extension ShowsCoordinator: ShowDetailsViewModelDelegate {
    func showDetailsViewModelDidUpdateEpisodes(_ viewModel: ShowDetailsViewModel) {
        // Já tratado no ViewController
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didFailWithError error: Error) {
        // Tratar erro se necessário
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didSelectEpisode episode: Episode) {
        showEpisodeDetails(episode)
    }
} 