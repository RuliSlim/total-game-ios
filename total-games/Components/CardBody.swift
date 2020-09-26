//
//  CardBody.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import GradientView

@IBDesignable
class CardBody: UIView {
	private let gradientView = GradientView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
		dropShadow()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUp()
		dropShadow()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func prepareForInterfaceBuilder() {
		setUp()
		dropShadow()
	}
	
	func dropShadow() {
			self.layer.masksToBounds = false
			self.layer.shadowColor = #colorLiteral(red: 0.9882352941, green: 0.337254902, blue: 0.09411764706, alpha: 1)
			self.layer.shadowOpacity = 1
			self.layer.shadowOffset = .init(width: 15, height: 15)
			self.layer.shadowRadius = 3
			self.round(corners: [.bottomRight, .topLeft], cornerRadius: 10)
	}
	
	private func setUp() {
		self.insertSubview(gradientView, at: 0)
//		self.layer.cornerRadius = 10
		self.round(corners: [.bottomRight, .topLeft], cornerRadius: 10)
//		gradientView.layer.cornerRadius = 10
		gradientView.clipsToBounds = true
		gradientView.direction = .horizontal
		gradientView.colors = [
			#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
			#colorLiteral(red: 0.1568627451, green: 0.1607843137, blue: 0.2470588235, alpha: 1)
		]
		gradientView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			gradientView.topAnchor.constraint(equalTo: self.topAnchor),
			gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
		
	}
}
