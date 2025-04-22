//
//  ShowsCoordinator.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import UIKit

final class ShowsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let service: TVMazeServiceProtocol
    
    init(navigationController: UINavigationController, service: TVMazeServiceProtocol) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let viewModel = ShowsListViewModel(service: service)
        viewModel.delegate = self
        let viewController = ShowsListViewController(viewModel: viewModel)
        viewModel.uiDelegate = viewController
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showShowDetails(_ show: Show) {
        let viewModel = ShowDetailsViewModel(show: show, service: service)
        viewModel.delegate = self
        let viewController = ShowDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showEpisodeDetails(_ episode: Episode) {
        let viewModel = EpisodeDetailsViewModel(episode: episode)
        let viewController = EpisodeDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension ShowsCoordinator: ShowsListViewModelDelegate {
    
    func showsListViewModelDidUpdateShows(_ viewModel: ShowsListViewModel) {
    }
    
    func showsListViewModel(_ viewModel: ShowsListViewModel, didFailWithError error: Error) {
    }
    
    func showsListViewModel(_ viewModel: ShowsListViewModel, didSelectShow show: Show) {
        showShowDetails(show)
    }
    
}

extension ShowsCoordinator: ShowDetailsViewModelDelegate {
    
    func showDetailsViewModelDidUpdateEpisodes(_ viewModel: ShowDetailsViewModel) {
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didFailWithError error: Error) {
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didSelectEpisode episode: Episode) {
        showEpisodeDetails(episode)
    }
    
}
