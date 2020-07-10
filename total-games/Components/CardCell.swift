//
//  CardCell.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

@IBDesignable
class CardCell: UICollectionViewCell {
    static var identifier = "CategoryItem"
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var totalGames: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropShadow()
    }
    
    public func configure(with card: Category) {
//        cardImage.image = UIImage(named: card.image)
        totalGames.text = String(card.games_count)
        title.text = card.name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CardCell", bundle: nil)
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .init(width: 5, height: 5)
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 10
    }
    
    func didTapped() {
        self.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = .init(width: 0, height: 0)
        self.layer.shadowRadius = 0
    }
}
