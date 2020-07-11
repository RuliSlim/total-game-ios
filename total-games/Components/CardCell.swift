//
//  CardCell.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import ImageLoader

class CardCell: UICollectionViewCell {
    static var identifier = "CategoryItem"
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var containerText: UIStackView!
    
    var totalGames: UILabel = UILabel()
    var title: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropShadow()
    }
    
    private func setup(name: String, games: String) {
        containerText.addArrangedSubview(self.title)
        containerText.addArrangedSubview(totalGames)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        
        totalGames.translatesAutoresizingMaskIntoConstraints = false
        totalGames.font = UIFont(name: "AmericanTypewriter-Condensed", size: 16)
        
        title.text = "\(name)"
        totalGames.text = "Games: \(games)"
    }
    
    public func configure(with card: Category, type: ContentType) {
        switch type {
        case .category:
            self.cardImage.load.request(with: card.image_background)
            let game = card.games_count.convertToStringNumber()
            setup(name: card.name, games: game)
        case .games:
            print("s")
        }
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
