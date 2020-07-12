//
//  Header.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import GradientView

@IBDesignable
class Header: GradientView {
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
            #colorLiteral(red: 0.9882352941, green: 0.337254902, blue: 0.09411764706, alpha: 1),
            #colorLiteral(red: 0.9647058824, green: 0.2705882353, blue: 0.3764705882, alpha: 1),
            #colorLiteral(red: 0.7843137255, green: 0.1882352941, blue: 0.8274509804, alpha: 1)
        ]
        self.round(corners: [.bottomRight, .bottomLeft], cornerRadius: 20)
        let deviceHeight = UIScreen.main.bounds.height
        let deviceWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: deviceWidth),
            self.heightAnchor.constraint(equalToConstant: deviceHeight * 0.1)
        ])
    }
}
