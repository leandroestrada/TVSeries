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
    
    private let window: UIWindow
    private let securityService: SecurityServiceProtocol
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.securityService = SecurityService()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showSecurity()
    }
    
    private func showSecurity() {
        let coordinator = SecurityCoordinator(navigationController: navigationController, securityService: securityService)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func showShows() {
        let service = TVMazeService()
        let coordinator = ShowsCoordinator(navigationController: navigationController, service: service)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: SecurityCoordinatorDelegate {
    func securityCoordinatorDidFinish(_ coordinator: SecurityCoordinator) {
        removeChildCoordinator(coordinator)
        showShows()
    }
}
