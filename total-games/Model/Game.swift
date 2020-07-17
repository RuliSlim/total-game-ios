//
//  Game.swift
//  total-games
//
//  Created by Ruli on 16/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation

struct Game: Decodable {
    let id: Int
    let name: String
    let description: String?
    let metacritic_platforms: [Metacritic]
    let released: String?
    let website: String?
    let rating: Double?
    let screenshots_count: Int?
    let background_image: String?
    let clip: Clip?
    let tba: Bool
    let platforms: [Platform]
    let developers: [Developer]?
    let genres: [Genre]?
    let publishers: [Publisher]?
    
    func getDev() -> String {
        var name = ""
        guard let developers = self.developers else { return "-" }
        for (i, el) in developers.enumerated() {
            if i != developers.count - 1 {
                name += el.name + ", "
            } else {
                name += el.name
            }
        }
        return name
    }
    
    func getGenre() -> String {
        var name = ""
        guard let genres = self.genres else { return "-" }
        for (i, el) in genres.enumerated() {
            if i != genres.count - 1 {
                name += el.name + ", "
            } else {
                name += el.name
            }
        }
        return name
    }
    
    func getPub() -> String {
        var name = ""
        guard let publishers = self.publishers else { return "-" }
        for (i, el) in publishers.enumerated() {
            if i != publishers.count - 1 {
                name += el.name + ", "
            } else {
                name += el.name
            }
        }
        return name
    }
    
    func getPlatform() -> String {
        var name = ""
        for (i, el) in self.platforms.enumerated() {
            if i != self.platforms.count - 1 {
                name += el.platform.name + ", "
            } else {
                name += el.platform.name
            }
        }
        return name
    }
}

struct Metacritic: Decodable {
    let metascore: Int
    let url: String
}

struct Clip: Decodable {
    let clip: String
    let preview: String
}

struct Platform: Decodable {
    let platform: ContentPlatform
}

struct ContentPlatform: Decodable {
    let name: String
}

struct Developer: Decodable {
    let name: String
}

struct Genre: Decodable {
    let name: String
}

struct Publisher: Decodable {
    let name: String
}

// MARK: -Screenshots
struct ResultScreenshot: Decodable {
    let count: Int
    let results: [Screenshot]
}

struct Screenshot: Decodable {
    let image: String
    let width: Int
    let height: Int
}
