//
//  TableListViewCell.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

protocol TableListViewCellDelegate: class {
    func didTapActionButton(_ sender: ToggleButton, id: Int?, stepperValue: String?)
}

class TableListViewCell: UITableViewCell {

    private lazy var hStackViewMainContainerConstraint = Layout.Constraint(topAnchor: 5, bottomAnchor: -5)
    private lazy var hStackViewMainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private lazy var leftContainerViewConstraint = Layout.Constraint(width: 120, height: 160)
    private lazy var leftContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var iconImageViewConstraint = Layout.Constraint(width: 55, height: 115)
    private lazy var iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.frame = CGRect(x: 0, y: 0, width: self.iconImageViewConstraint.width, height: self.iconImageViewConstraint.height)
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var stepperContainerViewConstraint = Layout.Constraint(height: 40)
    private lazy var stepperContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var stepperViewConstraint = Layout.Constraint()
    private lazy var stepperView: StepperView = {
        let view = StepperView(frame: CGRect(x: 0, y: 0, width: stepperContainerView.frame.width, height: stepperContainerViewConstraint.height))
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.start = 0
        return view
    }()

    private lazy var rightVStackContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var topVStackDetailsContainerConstraint = Layout.Constraint(trailingAnchor: -10)
    private lazy var topVStackDetailsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private lazy var topVStackDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = Fonts.helveticaNeue.bold.size(12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = Fonts.helveticaNeue.regular.size(11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = Fonts.helveticaNeue.regular.size(11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.green7Up.literal
        label.textAlignment = .left
        label.font = Fonts.helveticaNeue.bold.size(12)
        return label
    }()

    private lazy var actionButtonContainerViewConstraint = Layout.Constraint(height: 40)
    private lazy var actionButtonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var actionButtonConstraint = Layout.Constraint(trailingAnchor: -10, height: 30)
    private lazy var actionButton: KartButton = {
        let button = KartButton(normalState: "ADD", selectedState: Images.thick.literal, isSelected: false, borderColorNormalState: Colors.bluePepsi.literal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)
        return button
    }()

    var id: Int?
    weak var delegate: TableListViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        addViews()
        addViewsConstraints()
        updateViews()
    }

    private func addViews() {
        contentView.addSubview(hStackViewMainContainer)
        hStackViewMainContainer.addArrangedSubviews(views: [leftContainerView, rightVStackContainer])
        leftContainerView.addSubviews(views: [
            iconImageView,
            stepperContainerView
        ])
        stepperContainerView.addSubview(stepperView)
        rightVStackContainer.addArrangedSubviews(views: [
            topContainerView,
            actionButtonContainerView
        ])
        topContainerView.addSubview(topVStackDetailsContainer)
        topVStackDetailsContainer.addArrangedSubviews(views: [
            topVStackDetails,
            commentLabel
        ])
        topVStackDetails.addArrangedSubviews(views: [
            titleLabel,
            subtitleLabel,
            descriptionLabel
        ])
        actionButtonContainerView.addSubview(actionButton)
    }
    
    private func addViewsConstraints() {
        addHStackViewMainContainerConstraints()
        addLeftContainerViewConstraints()
        addIconImageViewConstraints()
        addStepperContainerViewConstraints()
        addStepperViewConstraints()
        addTopVStackDetailsContainerConstraints()
        addActionButtonContainerViewConstraints()
        addActionButtonConstraints()
    }

    private func addHStackViewMainContainerConstraints() {
        let leading = hStackViewMainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hStackViewMainContainerConstraint.leadingAnchor)
        leading.priority = .defaultHigh
        let bottom = hStackViewMainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: hStackViewMainContainerConstraint.bottomAnchor)
        bottom.priority = .defaultHigh
        let trailing = hStackViewMainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: hStackViewMainContainerConstraint.trailingAnchor)
        trailing.priority = .defaultHigh
        let top = hStackViewMainContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: hStackViewMainContainerConstraint.topAnchor)
        top.priority = .defaultHigh
        let centerY = hStackViewMainContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        NSLayoutConstraint.activate([leading, bottom, trailing, top, centerY])
    }

    private func addLeftContainerViewConstraints() {
        leftContainerView.widthAnchor.constraint(equalToConstant: leftContainerViewConstraint.width).isActive = true
    }

    private func addIconImageViewConstraints() {
        iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewConstraint.width).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewConstraint.height).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: leftContainerView.centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: leftContainerView.topAnchor, constant: iconImageViewConstraint.topAnchor).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: stepperContainerView.topAnchor, constant: iconImageViewConstraint.bottomAnchor).isActive = true
    }
    
    private func addStepperContainerViewConstraints() {
        stepperContainerView.heightAnchor.constraint(equalToConstant: stepperContainerViewConstraint.height).isActive = true
        stepperContainerView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: stepperContainerViewConstraint.leadingAnchor).isActive = true
        stepperContainerView.bottomAnchor.constraint(equalTo: leftContainerView.bottomAnchor, constant: stepperContainerViewConstraint.bottomAnchor).isActive = true
        stepperContainerView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor, constant: stepperContainerViewConstraint.trailingAnchor).isActive = true
    }

    private func addStepperViewConstraints() {
        stepperView.leadingAnchor.constraint(equalTo: stepperContainerView.leadingAnchor, constant: stepperViewConstraint.leadingAnchor).isActive = true
        stepperView.bottomAnchor.constraint(equalTo: stepperContainerView.bottomAnchor, constant: stepperViewConstraint.bottomAnchor).isActive = true
        stepperView.trailingAnchor.constraint(equalTo: stepperContainerView.trailingAnchor, constant: stepperViewConstraint.trailingAnchor).isActive = true
        stepperView.topAnchor.constraint(equalTo: stepperContainerView.topAnchor, constant: stepperViewConstraint.topAnchor).isActive = true
    }

    private func addTopVStackDetailsContainerConstraints() {
        topVStackDetailsContainer.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: topVStackDetailsContainerConstraint.leadingAnchor).isActive = true
        topVStackDetailsContainer.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: topVStackDetailsContainerConstraint.trailingAnchor).isActive = true
        topVStackDetailsContainer.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
    }

    private func addActionButtonContainerViewConstraints() {
        actionButtonContainerView.heightAnchor.constraint(equalToConstant: actionButtonContainerViewConstraint.height).isActive = true
    }
    
    private func addActionButtonConstraints() {
        actionButton.heightAnchor.constraint(equalToConstant: actionButtonConstraint.height).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: actionButtonContainerView.leadingAnchor, constant: actionButtonConstraint.leadingAnchor).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: actionButtonContainerView.trailingAnchor, constant: actionButtonConstraint.trailingAnchor).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: actionButtonContainerView.centerYAnchor).isActive = true
    }
    
    private func updateViews() {
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    private func setIconImageView(_ viewModel: TableListView.Model.Product) {
        iconImageView.downloadFrom(path: viewModel.image, placeholder: viewModel.placeholderImage)
    }
    
    private func setTitleLabel(_ text: String?) {
        guard let text = text else { return }
        titleLabel.text = text
    }
    
    private func setSubtitleLabel(_ text: String?) {
        guard let text = text else { return }
        subtitleLabel.text = text
    }

    private func setDescriptionLabel(_ text: String?) {
        guard let text = text else { return }
        descriptionLabel.text = text
    }

    private func setCommentLabel(_ text: NSAttributedString?) {
        guard let text = text else { return }
        commentLabel.attributedText = text
    }

    @objc private func didTapActionButton(_ sender: ToggleButton) {
        guard let value = stepperView.textField.text, let intValue = Int(value), intValue > 0 else {
            actionButton.isSelected.toggle()
            return
        }
        delegate?.didTapActionButton(sender, id: id, stepperValue: stepperView.textField.text)
    }

    public func setActionButtonSelected(_ isSelected: Bool) {
        actionButton.isSelected = isSelected
    }

    public func setStepperViewText(_ text: String?) {
        guard let text = text else { return }
        stepperView.textField.text = text
    }

    public func setup(_ viewModel: TableListView.Model.Product) {
        id = viewModel.id
        setIconImageView(viewModel)
        setTitleLabel(viewModel.title)
        setSubtitleLabel(viewModel.subtitle)
        setDescriptionLabel(viewModel.description)
        setCommentLabel(viewModel.comments)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        actionButton.prepareForReuse()
        stepperView.prepareForReuse()
    }
}

extension TableListViewCell: StepperViewDelegate {
    func didTapStepper() {
        guard let value = stepperView.textField.text, let intValue = Int(value), intValue > 0 else {
            return
        }
        actionButton.isEnabled = true
    }
}
