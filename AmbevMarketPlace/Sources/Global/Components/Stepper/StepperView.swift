//
//  StepperView.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol StepperViewDelegate: class {
    func didTapStepper()
}

class StepperView: UIView {

    weak var delegate: StepperViewDelegate?
    private lazy var hStackStepperContainerViewConstraint = Layout.Constraint(topAnchor: 5, bottomAnchor: -5)
    private lazy var hStackStepperContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
    }()

    private lazy var decreaseContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var decreaseButtonViewConstraint = Layout.Constraint(width: 25, height: 25)
    private lazy var decreaseButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var decreaseIconImageConstraint = Layout.Constraint(width: 10, height: 10)
    private lazy var decreaseIconImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = Images.remove.literal
        imgView.tintColor = Colors.bluePepsi.literal
        return imgView
    }()

    lazy var textField: UITextField = {
        let inputText = UITextField()
        inputText.textAlignment = .center
        inputText.borderStyle = .roundedRect
        inputText.translatesAutoresizingMaskIntoConstraints = false
        inputText.keyboardType = .numberPad
        inputText.backgroundColor = .white
        inputText.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        inputText.font = Fonts.helveticaNeue.regular.size(12)
        inputText.textColor = .black
        return inputText
    }()

    private lazy var increaseContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var increaseButtonViewConstraint = Layout.Constraint(width: 25, height: 25)
    private lazy var increaseButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var increaseIconImageConstraint = Layout.Constraint(width: 10, height: 10)
    private lazy var increaseIconImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = Images.more.literal
        imgView.tintColor = Colors.bluePepsi.literal
        return imgView
    }()
    
    var start: Int = 0 {
        didSet {
            textField.text = "\(self.start)"
        }
    }
    var maxNumber: Int = 99
    var minNumber: Int = 0
    var step: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupKeyboard()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupKeyboard()
        addTapGestureRecognizer()
    }

    private func setupViews() {
        backgroundColor = .clear
        addViews()
        addViewsConstraints()
        updateViews()
    }

    private func addViews() {
        addSubview(hStackStepperContainerView)
        hStackStepperContainerView.addArrangedSubviews(views: [decreaseContainerView, textField, increaseContainerView])
        decreaseContainerView.addSubview(decreaseButtonView)
        decreaseButtonView.addSubview(decreaseIconImage)
        increaseContainerView.addSubview(increaseButtonView)
        increaseButtonView.addSubview(increaseIconImage)
    }
    
    private func addViewsConstraints() {
        addHStackStepperContainerViewConstraints()
        addDecreaseButtonViewConstraints()
        addIncreaseButtonViewConstraints()
        addDecreaseIconImageConstraints()
        addIncreaseIconImageConstraints()
    }

    // MARK: - Setup Views
    
    private func updateViews() {
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
            self?.setViewsCornerRadius()
        }
    }
    
    private func addHStackStepperContainerViewConstraints() {
        hStackStepperContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: hStackStepperContainerViewConstraint.leadingAnchor).isActive = true
        hStackStepperContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: hStackStepperContainerViewConstraint.bottomAnchor).isActive = true
        hStackStepperContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: hStackStepperContainerViewConstraint.trailingAnchor).isActive = true
        hStackStepperContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: hStackStepperContainerViewConstraint.topAnchor).isActive = true
    }
    
    private func addDecreaseButtonViewConstraints() {
        decreaseButtonView.widthAnchor.constraint(equalToConstant: decreaseButtonViewConstraint.width).isActive = true
        decreaseButtonView.heightAnchor.constraint(equalToConstant: decreaseButtonViewConstraint.height).isActive = true
        decreaseButtonView.centerXAnchor.constraint(equalTo: decreaseContainerView.centerXAnchor).isActive = true
        decreaseButtonView.centerYAnchor.constraint(equalTo: decreaseContainerView.centerYAnchor).isActive = true
    }

    private func addIncreaseButtonViewConstraints() {
        increaseButtonView.widthAnchor.constraint(equalToConstant: increaseButtonViewConstraint.width).isActive = true
        increaseButtonView.heightAnchor.constraint(equalToConstant: increaseButtonViewConstraint.height).isActive = true
        increaseButtonView.centerXAnchor.constraint(equalTo: increaseContainerView.centerXAnchor).isActive = true
        increaseButtonView.centerYAnchor.constraint(equalTo: increaseContainerView.centerYAnchor).isActive = true
    }

    private func addDecreaseIconImageConstraints() {
        decreaseIconImage.widthAnchor.constraint(equalToConstant: decreaseIconImageConstraint.width).isActive = true
        decreaseIconImage.heightAnchor.constraint(equalToConstant: decreaseIconImageConstraint.height).isActive = true
        decreaseIconImage.centerXAnchor.constraint(equalTo: decreaseContainerView.centerXAnchor).isActive = true
        decreaseIconImage.centerYAnchor.constraint(equalTo: decreaseContainerView.centerYAnchor).isActive = true
    }
    
    private func addIncreaseIconImageConstraints() {
        increaseIconImage.widthAnchor.constraint(equalToConstant: increaseIconImageConstraint.width).isActive = true
        increaseIconImage.heightAnchor.constraint(equalToConstant: decreaseIconImageConstraint.height).isActive = true
        increaseIconImage.centerXAnchor.constraint(equalTo: increaseContainerView.centerXAnchor).isActive = true
        increaseIconImage.centerYAnchor.constraint(equalTo: increaseContainerView.centerYAnchor).isActive = true
    }

    private func setViewsCornerRadius() {
        decreaseButtonView.layer.cornerRadius = decreaseButtonView.bounds.width / 2
        decreaseButtonView.layer.borderWidth = 1
        decreaseButtonView.layer.borderColor = Colors.bluePepsi.literal.cgColor

        increaseButtonView.layer.cornerRadius = increaseButtonView.bounds.width / 2
        increaseButtonView.layer.borderWidth = 1
        increaseButtonView.layer.borderColor = Colors.bluePepsi.literal.cgColor
    }

    private func setupKeyboard() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = textField.bounds.height
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    @objc private func textDidChange(sender: UITextField) {
        IQKeyboardManager.shared.reloadLayoutIfNeeded()
        removeCharsExceedMaxLenght(textField: sender)
    }

    @objc private func removeCharsExceedMaxLenght(textField: UITextField) {
        guard var text = textField.text, let textNumbers: Int = Int(text), textNumbers > maxNumber else { return }
        text.removeLast()
        textField.text = text
    }
    
    private func addTapGestureRecognizer() {
        let tapIncreaseGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDecrease))
        decreaseButtonView.addGestureRecognizer(tapIncreaseGestureRecognizer)

        let tapDecreaseGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapIncrease))
        increaseButtonView.addGestureRecognizer(tapDecreaseGestureRecognizer)
    }

    @objc private func didTapDecrease() {
        guard let text = textField.text, let intValue = Int(text), (intValue-step) >= minNumber else { return }
        textField.text = "\(intValue - step)"
        delegate?.didTapStepper()
    }

    @objc private func didTapIncrease() {
        guard let text = textField.text, let intValue = Int(text), (intValue+step) <= maxNumber else { return }
        textField.text = "\(intValue + step)"
        delegate?.didTapStepper()
    }
    
    public func prepareForReuse() {
        textField.text = "\(start)"
    }
    
}
