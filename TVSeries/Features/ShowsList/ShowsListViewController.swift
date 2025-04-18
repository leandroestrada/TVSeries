//
//  ShowsListViewController.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class ShowsListViewController: UIViewController {
    
    private let viewModel: ShowsListViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private let contentView: ShowsListView
    
    init(viewModel: ShowsListViewModel) {
        self.viewModel = viewModel
        self.contentView = ShowsListView()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        Task {
            await viewModel.loadNextPage()
        }
    }
    
    private func setupUI() {
        title = "TV Shows"
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Shows"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}

extension ShowsListViewController: ShowsListViewDelegate {
    
    func showsListView(_ view: ShowsListView, didSelectShowAt indexPath: IndexPath) {
        let show = viewModel.shows[indexPath.row]
        let detailsViewModel = ShowDetailsViewModel(show: show, service: TVMazeService())
        let detailsViewController = ShowDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

extension ShowsListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            Task {
                await viewModel.resetSearch()
            }
            return
        }
        
        Task {
            await viewModel.searchShows(query: query)
        }
    }
    
}

extension ShowsListViewController: ShowsListViewModelDelegate {
    
    func showsListViewModelDidUpdateShows(_ viewModel: ShowsListViewModel) {
        DispatchQueue.main.async {
            self.contentView.configure(with: viewModel)
        }
    }
    
    func showsListViewModel(_ viewModel: ShowsListViewModel, didFailWithError error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
}
