//
//  Games.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation

struct Games: Decodable {
    let id: Int
    let name: String
    let background_image: String
    let rating: Double?
    let short_screenshots: [Screenshot]?
}

struct Screenshot: Decodable {
    let image: String?
}

struct ResultGames: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Games]
}
