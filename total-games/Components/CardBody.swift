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
		self.insertSubview(gradientView, at: 0)
		self.layer.cornerRadius = 10
		gradientView.layer.cornerRadius = 10
		gradientView.clipsToBounds = true
		gradientView.direction = .horizontal
		gradientView.colors = [
			#colorLiteral(red: 0.9882352941, green: 0.337254902, blue: 0.09411764706, alpha: 1),
			#colorLiteral(red: 0.9647058824, green: 0.2705882353, blue: 0.3764705882, alpha: 1),
			#colorLiteral(red: 0.7843137255, green: 0.1882352941, blue: 0.8274509804, alpha: 1)
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
