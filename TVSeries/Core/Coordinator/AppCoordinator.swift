//
//  AppCoordinator.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showShowsList()
    }
    
    private func showShowsList() {
        let service = TVMazeService()
        let viewModel = ShowsListViewModel(service: service)
        let viewController = ShowsListViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
