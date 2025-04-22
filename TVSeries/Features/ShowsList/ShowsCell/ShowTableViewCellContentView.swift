//
//  ShowTableViewCellContentView.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class ShowTableViewCellContentView: UIView {
    
    private let showImageView: UIImageView = {
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
        label.textColor = .label
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
        
        addSubview(showImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            showImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Spacing.medium),
            showImageView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.Spacing.small),
            showImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.Spacing.small),
            showImageView.widthAnchor.constraint(equalToConstant: UIConstants.ShowsList.imageWidth),
            showImageView.heightAnchor.constraint(equalToConstant: UIConstants.ShowsList.imageHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Spacing.medium),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with show: Show) {
        titleLabel.text = show.name
        
        if let imageURLString = show.image?.medium,
           let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.showImageView.image = image
                    }
                }
            }.resume()
        } else {
            showImageView.image = UIImage(systemName: "tv")
            showImageView.tintColor = .systemGray3
        }
    }
    
    func prepareForReuse() {
        showImageView.image = nil
        titleLabel.text = nil
    }
    
}
