//
//  EpisodeDetailsViewController.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class EpisodeDetailsViewController: UIViewController {
    
    private let viewModel: EpisodeDetailsViewModel
    private let contentView: EpisodeDetailsView
    
    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
        self.contentView = EpisodeDetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
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
    }
    
    private func configureUI() {
        title = viewModel.title
        contentView.configure(with: viewModel)
    }
    
}
