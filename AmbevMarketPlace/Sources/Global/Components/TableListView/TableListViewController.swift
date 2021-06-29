//
//  TableListViewController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

protocol TableListViewDelegate: class {
    func didTapKartButton(_ isSelected: Bool, _ id: Int, _ stepperValue: String)
}

class TableListViewController: UIViewController {

    weak var delegate: TableListViewDelegate?

    fileprivate lazy var toolbarViewConstraint = Layout.Constraint(height: 40)
    fileprivate lazy var toolbarView: ToolbarView = {
        let view = ToolbarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.toolbarViewConstraint.height))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.redAmbev.literal
        view.setup(items: [sorterButton])
        return view
    }()

    private lazy var sorterButton: ToggleButton = {
        let button = ToggleButton(normalState: Images.sortAsc.literal, selectedState: Images.sortDesc.literal, isSelected: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSortButton(_:)), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()

    fileprivate lazy var tableListViewConstraints: Layout.Constraint = Layout.Constraint(bottomAnchor: 10)
    lazy var tableListView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = true
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TableListViewCell.self, forCellReuseIdentifier: String(describing: TableListViewCell.self))
        tableView.dataSource = self
        return tableView
    }()

    private lazy var loadingViewConstraint = Layout.Constraint()
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var tableViewModel: [TableListView.Model.Product]? {
        didSet {
            self.reloadData()
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    fileprivate func setupViews() {
        view.backgroundColor = .white
        addViews()
        addViewsConstraints()
    }

    fileprivate func addViews() {
        view.addSubviews(views: [
            toolbarView,
            tableListView,
            loadingView
        ])
    }
    
    fileprivate func addViewsConstraints() {
        addToolbarViewConstraints()
        addListTableViewConstraints()
        addLoadingViewConstraints()
    }

    fileprivate func addToolbarViewConstraints() {
        toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: toolbarViewConstraint.leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: toolbarViewConstraint.trailingAnchor).isActive = true
        toolbarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: toolbarViewConstraint.topAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: toolbarViewConstraint.height).isActive = true
    }

    fileprivate func addListTableViewConstraints() {
        tableListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableListViewConstraints.leadingAnchor).isActive = true
        tableListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: tableListViewConstraints.bottomAnchor).isActive = true
        tableListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: tableListViewConstraints.trailingAnchor).isActive = true
        tableListView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: tableListViewConstraints.topAnchor).isActive = true
    }

    private func addLoadingViewConstraints() {
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loadingViewConstraint.leadingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: loadingViewConstraint.bottomAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: loadingViewConstraint.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: loadingViewConstraint.topAnchor).isActive = true
    }
    
    public func animateScreen(_ isLoading: Bool) {
        isLoading ? loadingView.animateScreen(true) : loadingView.animateScreen(false)
    }

    public func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableListView.reloadData()
        }
    }

    @objc private func didTapSortButton(_ sender: ToggleButton) {
        didTapSort(isSelected: sender.isSelected)
    }

    public func setViewModel(_ viewModel: TableListView.Model.ViewModel?) {
        tableViewModel = viewModel?.products
    }
    
    public func setTableViewContentOffset(position: IndexPath) {
        tableListView.scrollToRow(at: position, at: .top, animated: true)
    }

    func didTapSort(isSelected: Bool) {}

}

extension TableListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableListViewCell.self), for: indexPath) as? TableListViewCell, let viewModel = tableViewModel?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.setStepperViewText(viewModel.stepperValue)
        cell.setActionButtonSelected(viewModel.isSelected)
        cell.setup(viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel?.count ?? 0
    }
}

extension TableListViewController: TableListViewCellDelegate {
    func didTapActionButton(_ sender: ToggleButton, id: Int?, stepperValue: String?) {
        guard let id = id, let stepperValue = stepperValue else { return }
        delegate?.didTapKartButton(sender.isSelected, id, stepperValue)
    }
}
