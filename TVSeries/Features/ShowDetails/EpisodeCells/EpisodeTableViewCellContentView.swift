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
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
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
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            episodeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            episodeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            episodeImageView.heightAnchor.constraint(equalToConstant: 56),
            
            titleLabel.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            episodeNumberLabel.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 16),
            episodeNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            episodeNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            episodeNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
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
