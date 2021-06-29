//
//  ToolbarView.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class ToolbarView: UIView {

    private lazy var stackContainerViewConstraint = Layout.Constraint(topAnchor: 5, leadingAnchor: 10, trailingAnchor: -10, bottomAnchor: -5)
    private lazy var stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addViews()
        addViewsConstraints()
    }
    
    private func addViews() {
        addSubview(stackContainerView)
    }

    private func addViewsConstraints() {
        addStackContainerViewConstraints()
    }
    
    private func addViewsConstraints(_ items: [ToggleButton]) {
        items.forEach { (item) in
            item.widthAnchor.constraint(equalToConstant: frame.height).isActive = true
        }
    }

    private func addStackContainerViewConstraints() {
        stackContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: stackContainerViewConstraint.leadingAnchor).isActive = true
        stackContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: stackContainerViewConstraint.bottomAnchor).isActive = true
        stackContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: stackContainerViewConstraint.trailingAnchor).isActive = true
        stackContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: stackContainerViewConstraint.topAnchor).isActive = true
    }

    private func addViewToStack(_ items: [ToggleButton]) {
        stackContainerView.addArrangedSubview(separatorView)
        items.forEach { (item) in
            stackContainerView.addArrangedSubview(item)
        }
    }

    public func setup(items: [ToggleButton]) {
        addViewToStack(items)
    }
}
