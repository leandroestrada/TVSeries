//
//  ShowDetailsViewController.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class ShowDetailsViewController: UIViewController {
    
    private let viewModel: ShowDetailsViewModel
    private let contentView: ShowDetailsView
    
    init(viewModel: ShowDetailsViewModel) {
        self.viewModel = viewModel
        self.contentView = ShowDetailsView()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        Task {
            await viewModel.loadEpisodes()
        }
    }
    
    private func setupUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.delegate = self
    }
    
    private func configureUI() {
        title = viewModel.show.name
        contentView.configure(with: viewModel)
    }
}

extension ShowDetailsViewController: ShowDetailsViewDelegate {
    
    func showDetailsView(_ view: ShowDetailsView, didSelectEpisodeAt indexPath: IndexPath) {
        guard let episode = viewModel.episode(at: indexPath) else { return }
        viewModel.didSelectEpisode(episode)
    }
    
}

extension ShowDetailsViewController: ShowDetailsViewModelDelegate {
    
    func showDetailsViewModelDidUpdateEpisodes(_ viewModel: ShowDetailsViewModel) {
        DispatchQueue.main.async {
            self.contentView.configure(with: viewModel)
        }
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didFailWithError error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func showDetailsViewModel(_ viewModel: ShowDetailsViewModel, didSelectEpisode episode: Episode) {
    }
}
