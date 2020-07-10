//
//  Card.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation


struct Category: Decodable {
    let id: Int
    let name: String
    let image_background: String
    let games_count: Int
}

struct ResultCategory: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Category]
}
