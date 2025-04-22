//
//  ShowTableViewCell.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

final class ShowTableViewCell: UITableViewCell {
    
    static let identifier = "ShowTableViewCell"
    
    private let customContentView: ShowTableViewCellContentView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.customContentView = ShowTableViewCellContentView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customContentView)
        
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with show: Show) {
        customContentView.configure(with: show)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customContentView.prepareForReuse()
    }
    
}
