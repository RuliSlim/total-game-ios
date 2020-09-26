//
//  CardImage.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

@IBDesignable
class CardImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        setUp()
    }
    
    private func setUp() {
        self.round(corners: [.bottomRight, .topLeft], cornerRadius: 10)
    }
}
