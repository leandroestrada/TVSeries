//
//  EpisodeTableViewCell.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    
    static let identifier = "EpisodeTableViewCell"
    
    private let customContentView: EpisodeTableViewCellContentView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.customContentView = EpisodeTableViewCellContentView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customContentView)
        
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with episode: Episode) {
        customContentView.configure(with: episode)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customContentView.prepareForReuse()
    }
    
}
