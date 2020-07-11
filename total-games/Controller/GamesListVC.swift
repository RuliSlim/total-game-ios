//
//  GamesListVC.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

class GamesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    
    private func initialSetup() {
        Api.shared.page = 1
        getData()
    }
    
    private func getData() {
        Api.shared.getGames { (res) in
            switch res {
            case .success((let data, let next, let previous)):
                print(data, "ini hasil call")
            case .failure(let err):
                print(err)
            }
        }
    }
}
