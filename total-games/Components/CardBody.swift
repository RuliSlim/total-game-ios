//
//  CardBody.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

@IBDesignable
class CardBody: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForInterfaceBuilder() {
        setUp()
    }
    
    private func setUp() {
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.01960784314, blue: 0.06666666667, alpha: 1)
        self.layer.cornerRadius = 10
    }
}
