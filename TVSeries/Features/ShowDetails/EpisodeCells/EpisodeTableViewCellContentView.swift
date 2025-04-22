//
//  EpisodeTableViewCellContentView.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class EpisodeTableViewCellContentView: UIView {
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = UIConstants.CornerRadius.small
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.subtitle
        label.numberOfLines = 2
        return label
    }()
    
    private let episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.caption
        label.textColor = .secondaryLabel
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
        addSubview(episodeImageView)
        addSubview(titleLabel)
        addSubview(episodeNumberLabel)
        
        NSLayoutConstraint.activate([
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            episodeImageView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.Spacing.small),
            episodeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.Spacing.small),
            episodeImageView.widthAnchor.constraint(equalToConstant: UIConstants.EpisodeCell.imageWidth),
            episodeImageView.heightAnchor.constraint(equalToConstant: UIConstants.EpisodeCell.imageHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.Spacing.small),
            
            episodeNumberLabel.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: UIConstants.Spacing.medium),
            episodeNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            episodeNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.CornerRadius.small),
            episodeNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -UIConstants.Spacing.small)
        ])
    }
    
    func configure(with episode: Episode) {
        titleLabel.text = episode.name
        episodeNumberLabel.text = "Episode \(episode.number ?? 0)"
        
        if let imageURLString = episode.image?.medium,
           let imageURL = URL(string: imageURLString) {
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
    
    func prepareForReuse() {
        episodeImageView.image = nil
        titleLabel.text = nil
        episodeNumberLabel.text = nil
    }
    
}
