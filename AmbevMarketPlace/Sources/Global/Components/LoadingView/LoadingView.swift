//
//  LoadingView.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private lazy var containerViewConstraint = Layout.Constraint()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.center = self.center
        activityIndicator.color = UIColor.gray
        return activityIndicator
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        stopAnimating()
    }

    // MARK: - Setup Views

    private func setupViews() {
        self.backgroundColor = .white
        addViews()
    }

    private func addViews() {
        self.addSubview(activityIndicator)
    }

    private func stopAnimating() {
        activityIndicator.stopAnimating()
        self.alpha = 0
    }

    private func startAnimating() {
        activityIndicator.startAnimating()
        self.alpha = 1
    }

    public func animateScreen(_ isLoading: Bool) {
        isLoading ? startAnimating() : stopAnimating()
    }

}
