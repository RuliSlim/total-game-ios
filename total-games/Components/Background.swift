//
//  Background.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import GradientView

@IBDesignable
class Background: GradientView {
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.direction = .horizontal
        self.colors = [
            #colorLiteral(red: 0.1098039216, green: 0.09803921569, blue: 0.1803921569, alpha: 1),
            #colorLiteral(red: 0.1254901961, green: 0.1333333333, blue: 0.2078431373, alpha: 1)
        ]
        self.translatesAutoresizingMaskIntoConstraints = true
    }

}
