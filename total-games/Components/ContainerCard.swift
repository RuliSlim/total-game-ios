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
    private var _topLeft: UIRectCorner = []
    private var _bottomLeft: UIRectCorner = []
    private var _topRight: UIRectCorner = []
    private var _bottomRight: UIRectCorner = []
    private var _radius: Double = 20
    private var _borders: [ViewSide] = []
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    @IBInspectable
    var topBorder: Bool = false {
        didSet {
            if topBorder {
                _borders.append(.top)
            } else {
                _borders.removeAll(where: { $0 == .top })
            }
        }
    }
    
    @IBInspectable
    var topLeft: Bool = true {
        didSet {
            if topLeft {
                self._topLeft = .topLeft
            } else {
                self._topLeft = []
            }
        }
    }
    
    @IBInspectable
    var bottomLeft: Bool = true {
        didSet {
            if bottomLeft {
                self._bottomLeft = .bottomLeft
            } else {
                self._bottomLeft = []
            }
        }
    }
    
    @IBInspectable
    var topRight: Bool = true {
        didSet {
            if topRight {
                self._topRight = .topRight
            } else {
                self._topRight = []
            }
        }
    }
    
    @IBInspectable
    var bottomRight: Bool = true {
        didSet {
            if bottomRight {
                self._bottomRight = .bottomRight
            } else {
                self._bottomRight = []
            }
        }
    }
    
    @IBInspectable
    var radius: Double = 20 {
        didSet {
            self._radius = radius
        }
    }

    private func setup() {
        self.round(corners: [_topRight, _topLeft, _bottomRight, _bottomLeft], cornerRadius: _radius)
//        self.addBorder(corners: _borders, thickness: 3, color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), offset: 1)
//        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        self.layer.borderWidth = 10
    }

}
