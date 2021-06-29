//
//  KartButton.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class KartButton: UIButton {

    private var borderColorNormalState: UIColor?

    override var isSelected: Bool {
        didSet {
            updateDisplay()
        }
    }

    var selectedState: UIImage? {
        didSet {
            updateDisplay()
        }
    }

    var normalState: String? {
        didSet {
            updateDisplay()
        }
    }

    init(normalState: String, selectedState: UIImage, isSelected: Bool, borderColorNormalState: UIColor) {
        super.init(frame: .zero)
        self.normalState = normalState
        self.selectedState = selectedState
        self.isSelected = isSelected
        self.borderColorNormalState = borderColorNormalState
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.normalState = "ADD"
        self.selectedState = Images.thick.literal
        self.isSelected = true
        self.borderColorNormalState = Colors.bluePepsi.literal
    }

    private func toggleBackground(_ image: UIImage?, for state: UIControl.State) {
        guard let image = image else { return }
        setTitle("", for: state)
        backgroundColor = .silver
        setImage(image, for: state)
        layer.borderColor = UIColor.silver.cgColor
        tintColor = .darkGray
    }
    
    private func toggleBackground(_ text: String?, for state: UIControl.State) {
        guard let text = text else { return }
        backgroundColor = .clear
        setTitleColor(Colors.bluePepsi.literal, for: state)
        titleLabel?.font = Fonts.helveticaNeue.bold.size(13)
        setTitle(text, for: state)
        layer.borderColor = borderColorNormalState?.cgColor
    }

    func updateDisplay() {
        isSelected ? toggleBackground(selectedState, for: .selected) : toggleBackground(normalState, for: .normal)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        isSelected = !isSelected
    }

    public func prepareForReuse() {
        isSelected = false
    }
    
}
