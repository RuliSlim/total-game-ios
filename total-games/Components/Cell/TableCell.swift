//
//  TableCell.swift
//  total-games
//
//  Created by Ruli on 12/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    static var identifier = "TableCell"
    
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var ratingCell: UILabel!
    @IBOutlet weak var releasedCell: UILabel!
    @IBOutlet weak var imageCell: CardImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TableCell", bundle: nil)
    }
    
    func configure(game: Games) {
        titleCell.text = game.name
        releasedCell.text = "Released: \(game.released ?? "TBA")"
        ratingCell.text = rating(rating: game.rating ?? 0)
        imageCell.load.request(with: game.background_image)
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
    
}
