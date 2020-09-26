//
//  Footer.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import GradientView

@IBDesignable
class Footer: GradientView {
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
            #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
            #colorLiteral(red: 0.1568627451, green: 0.1607843137, blue: 0.2470588235, alpha: 1)
        ]
        let deviceHeight = UIScreen.main.bounds.height
        let deviceWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: deviceWidth),
            self.heightAnchor.constraint(equalToConstant: deviceHeight * 0.1)
        ])
        
        self.round(corners: [.topLeft, .topRight], cornerRadius: 20)
    }
}
