//
//  ToggleButton.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {

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

    var normalState: UIImage? {
        didSet {
            updateDisplay()
        }
    }

    init(normalState: UIImage, selectedState: UIImage, isSelected: Bool) {
        super.init(frame: .zero)
        self.normalState = normalState
        self.selectedState = selectedState
        self.isSelected = isSelected
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.normalState = Images.sortAsc.literal
        self.selectedState = Images.sortDesc.literal
        self.isSelected = true
    }

    private func toggleBackground(_ image: UIImage?, for state: UIControl.State) {
        guard let image = image else { return }
        setBackgroundImage(image, for: state)
    }

    func updateDisplay() {
        isSelected ? toggleBackground(selectedState, for: .selected) : toggleBackground(normalState, for: .normal)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        isSelected = !isSelected
    }
    
}
