//
//  ViewExtension.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

extension UIView {
    enum ViewSide {
        case left
        case top
        case right
        case bottom
    }
    
    /// Make side to round
    func round(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath

        self.layer.mask = shapeLayer
    }
    
    // MARK: - Function add specific border
    /// Make border on side
    func addBorder(corners: [ViewSide], thickness: CGFloat, color: CGColor, offset: CGFloat) {
        for corner in corners {
            var frame: CGRect!
            switch corner {
            case .left:
                frame = CGRect(x: -offset, y: -offset, width: thickness, height: self.frame.height + offset)
                drawBorder(frame: frame, color: color)
            case .top:
                frame = CGRect(x: -offset, y: -offset, width: self.frame.width + offset, height: thickness)
                drawBorder(frame: frame, color: color)
            case .right:
                frame = CGRect(x: self.frame.maxX + offset, y: 0, width: thickness, height: self.frame.height)
                drawBorder(frame: frame, color: color)
            case .bottom:
                frame = CGRect(x: 0, y: self.frame.maxY + offset, width: self.frame.width, height: thickness)
                drawBorder(frame: frame, color: color)
            }
        }
    }
    
    fileprivate func drawBorder(frame: CGRect, color: CGColor) {
        let border: CALayer = CALayer()
        border.frame = frame
        
        let colors = [ UIColor.red.cgColor, UIColor.blue.cgColor ]
        let gradView = CAGradientLayer()
        gradView.frame = border.frame
        gradView.colors = colors
        gradView.startPoint = CGPoint(x: 0, y: 0.5)
        gradView.endPoint = CGPoint(x: 1, y: 0)
        
        border.addSublayer(gradView)
        self.layer.addSublayer(border)
    }
}
