//
//  ShowsListView.swift
//  TVSeries
//
//  Created by leandro estrada on 18/04/25.
//

import UIKit

protocol ShowsListViewDelegate: AnyObject {
    func showsListView(_ view: ShowsListView, didSelectShowAt indexPath: IndexPath)
}

final class ShowsListView: UIView {
    weak var delegate: ShowsListViewDelegate?
    private var viewModel: ShowsListViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UIConstants.ShowsList.cellHeight
        tableView.separatorInset = UIConstants.ShowsList.separatorInsets
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
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with viewModel: ShowsListViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}


extension ShowsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.shows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.identifier, for: indexPath) as? ShowTableViewCell,
              let show = viewModel?.shows[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: show)
        return cell
    }
    
}

extension ShowsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let lastItem = viewModel.shows.count - 1
        if indexPath.row == lastItem {
            Task {
                await viewModel.loadNextPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.showsListView(self, didSelectShowAt: indexPath)
    }
}
