//
//  ButtonPanel.swift
//  total-games
//
//  Created by Ruli on 14/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import TTSegmentedControl
import GradientView

@IBDesignable
class ButtonPanel: UIControl {
    
    private var labels: [UILabel] = [UILabel]()
    private var thumbView: UIView = UIView()

    private let _gradientView = GradientView()
    private let _colors = [
        #colorLiteral(red: 0.9882352941, green: 0.337254902, blue: 0.09411764706, alpha: 1),
        #colorLiteral(red: 0.9647058824, green: 0.2705882353, blue: 0.3764705882, alpha: 1),
        #colorLiteral(red: 0.7843137255, green: 0.1882352941, blue: 0.8274509804, alpha: 1)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
//        fatalError("init(coder:) has not been implemented")
    }
    
//    override func prepareForInterfaceBuilder() {
//        setup()
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        
        thumbView.backgroundColor = .red
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0 ... labels.count - 1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if let calculatedIndex = calculatedIndex {
            selectedIndex = calculatedIndex
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    @IBInspectable var textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var items: [String] = ["One", "Two", "Three"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    
    fileprivate func setup() {
        let gradView = CAGradientLayer()
        gradView.colors = _colors
        gradView.startPoint = CGPoint(x: 0, y: 0.5)
        gradView.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 2
        self.layer.mask = gradView
        
        setupLabels()
        
        insertSubview(thumbView, at: 0)
    }
    
    fileprivate func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1 ... labels.count {
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index - 1]
            label.textAlignment = .center
            label.textColor = textColor
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    fileprivate func displayNewSelectedIndex() {
        let label = labels[selectedIndex]
        self.thumbView.frame = label.frame
    }
    
}
