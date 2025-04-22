//
//  EpisodeDetailsView.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class EpisodeDetailsView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = UIConstants.CornerRadius.medium
        return imageView
    }()
    
    private let episodeInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.body
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.body
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(episodeImageView)
        contentView.addSubview(episodeInfoLabel)
        contentView.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            episodeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.Spacing.medium),
            episodeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            episodeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            episodeImageView.heightAnchor.constraint(equalTo: episodeImageView.widthAnchor, multiplier: UIConstants.EpisodeDetails.imageAspectRatio),
            
            episodeInfoLabel.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor, constant: UIConstants.Spacing.medium),
            episodeInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            episodeInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            summaryLabel.topAnchor.constraint(equalTo: episodeInfoLabel.bottomAnchor, constant: UIConstants.Spacing.medium),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.Spacing.medium)
        ])
    }
    
    func configure(with viewModel: EpisodeDetailsViewModel) {
        episodeInfoLabel.text = viewModel.episodeInfo
        summaryLabel.text = viewModel.cleanSummary
        
        if let imageURL = viewModel.imageURL {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.episodeImageView.image = image
                    }
                }
            }.resume()
        } else {
            episodeImageView.image = UIImage(systemName: "tv")
            episodeImageView.tintColor = .systemGray3
        }
    }
    
}
