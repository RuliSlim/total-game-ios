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
    
    static func nib() -> UINib {
        return UINib(nibName: "CardCell", bundle: nil)
    }
    
    public func configure(content: Any, type: ContentType) {
        switch type {
        case .category:
            forCategory(content: content as! Category)
        case .games:
            forGames(content: content as! Games)
        }
    }
    
    private func forCategory(content: Category) {
        self.cardImage.load.request(with: content.image_background)
        let game = content.games_count.convertToStringNumber()
        setup(name: content.name, games: game, type: .category)
    }
    
    private func forGames(content: Games) {
        self.cardImage.load.request(with: content.background_image)
        
        let stringRating = rating(rating: content.rating ?? 0)
        setup(name: content.name, games: stringRating, type: .games)
    }
    
    private func rating(rating: Double) -> String {
        var stringRating = ""
        let rating = rating
        let oneStar = "★"
        let emptyStar = "☆"
        
        switch rating {
        case 0 ... 1:
            stringRating = "Rating: \(oneStar)\(emptyStar)\(emptyStar)\(emptyStar)\(emptyStar)"
        case 1 ... 2:
            stringRating = "Rating: \(oneStar)\(oneStar)\(emptyStar)\(emptyStar)\(emptyStar)"
        case 2 ... 3:
            stringRating = "Rating: \(oneStar)\(oneStar)\(oneStar)\(emptyStar)\(emptyStar)"
        case 3 ... 4:
            stringRating = "Rating: \(oneStar)\(oneStar)\(oneStar)\(oneStar)\(emptyStar)"
        default:
            stringRating = "Rating: \(oneStar)\(oneStar)\(oneStar)\(oneStar)\(oneStar)"
        }
        return stringRating
    }
    
    private func setup(name: String, games: String, type: ContentType) {
        containerText.addArrangedSubview(self.title)
        containerText.addArrangedSubview(totalGames)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "AvernirNext-Bold", size: 18)
        
        totalGames.translatesAutoresizingMaskIntoConstraints = false
        totalGames.font = UIFont(name: "AvenirNext-Condensed", size: 16)
        
        title.text = "\(name)"
        switch type {
        case .category:
            totalGames.text = "Games: \(games)"
        case .games:
            totalGames.text = "\(games)"
        }
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
