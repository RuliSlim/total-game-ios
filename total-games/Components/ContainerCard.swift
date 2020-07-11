//
//  ContainerCard.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

@IBDesignable
class ContainerCard: UIView {
    
    override func prepareForInterfaceBuilder() {
        setup()
    }

    private func setup() {
        self.round(corners: [.allCorners], cornerRadius: 20)
    }

}
