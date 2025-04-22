//
//  ShowDetailsView.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

protocol ShowDetailsViewDelegate: AnyObject {
    func showDetailsView(_ view: ShowDetailsView, didSelectEpisodeAt indexPath: IndexPath)
}

final class ShowDetailsView: UIView {
    
    weak var delegate: ShowDetailsViewDelegate?
    private var viewModel: ShowDetailsViewModel?
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
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
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = UIConstants.CornerRadius.medium
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.title
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let scheduleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIConstants.Font.body
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let genresLabel: UILabel = {
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
    
    private let episodesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
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
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(episodesTableView)
        
        tableViewHeightConstraint = episodesTableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
        
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
            
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.Spacing.medium),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: UIConstants.ShowDetails.posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: UIConstants.ShowDetails.posterHeight),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            scheduleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.Spacing.small),
            scheduleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            scheduleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            genresLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: UIConstants.Spacing.small),
            genresLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            genresLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            summaryLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: UIConstants.Spacing.medium),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Spacing.medium),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Spacing.medium),
            
            episodesTableView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: UIConstants.Spacing.large),
            episodesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    func configure(with viewModel: ShowDetailsViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.show.name
        scheduleLabel.text = viewModel.formattedSchedule
        genresLabel.text = viewModel.formattedGenres
        summaryLabel.text = viewModel.cleanSummary
        
        if let imageURLString = viewModel.show.image?.original,
           let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                }
            }.resume()
        } else {
            posterImageView.image = UIImage(systemName: "tv")
            posterImageView.tintColor = .systemGray3
        }
        
        episodesTableView.reloadData()
        episodesTableView.layoutIfNeeded()
        
        let height = episodesTableView.contentSize.height
        tableViewHeightConstraint?.constant = height
    }
}

extension ShowDetailsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSeasons() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        let season = viewModel.season(at: section)
        return viewModel.episodes(for: season).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell,
              let viewModel = viewModel,
              let episode = viewModel.episode(at: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(with: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        let season = viewModel.season(at: section)
        return "Season \(season)"
    }
    
}

extension ShowDetailsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.ShowDetails.episodeCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.showDetailsView(self, didSelectEpisodeAt: indexPath)
    }
    
}
