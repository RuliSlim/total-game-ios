//
//  Api.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import Foundation

class Api {
    static let shared = Api()
    
    let URL_BASE = "https://api.rawg.io/api"
    let session = URLSession(configuration: .default)
    var page = 1
    var category = 1
    var dates = ""
    var sortBy = "-added"
    
    
    func getCategory(completion: @escaping (Result<([Category], next: String?, previous: String?), Error>) -> Void ) {
        guard let url = URL(string: "\(URL_BASE)/platforms?page=\(page)&page_size=6") else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure("Invalid data or response" as! Error))
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let result: ResultCategory = try JSONDecoder().decode(ResultCategory.self, from: data)
                        let categories: [Category] = result.results
                        completion(.success((categories, result.next, result.previous)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getGames(completion: @escaping (Result<([Games], next: String?, previous: String?), Error>) -> Void) {
        
        guard let url = URL(string: "\(URL_BASE)/games?platforms=\(category)&page_size=10&dates=\(dates)&ordering=\(sortBy)") else { return }
        
        let task = session.dataTask(with: url) { (data, response, error)  in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure("Invalid data or response" as! Error))
                    return
                }
                
                guard response.statusCode == 200 else { return }
                
                do {
                    let result: ResultGames = try JSONDecoder().decode(ResultGames.self, from: data)
                    let games: [Games] = result.results
                    completion(.success((games, next: result.next, previous: result.previous)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getRecentGames(completion: @escaping (Result<([Games], next: String?, previous: String?), Error>) -> Void) {
        
        guard let url = URL(string: "\(URL_BASE)/games?platforms=\(category)&page_size=10&dates=\(dates)&ordering=\(sortBy)") else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure("Invalid data or response" as! Error))
                    return
                }
                
                guard response.statusCode == 200 else { return }
                
                do {
                    let result: ResultGames = try JSONDecoder().decode(ResultGames.self, from: data)
                    let games: [Games] = result.results
                    completion(.success((games, next: result.next, previous: result.previous)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
}
