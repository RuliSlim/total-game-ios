//
//  GamesListVC.swift
//  total-games
//
//  Created by Ruli on 11/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

class GamesListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    private var _title: String!
    private var _year: String!
    
    private var _games: [Games] = []
    private var _recentGames: [Games] = []
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(TableCell.nib(), forCellReuseIdentifier: TableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        initialSetup()
        refreshControl.addTarget(self, action: #selector(refreshAll), for: UIControl.Event.valueChanged)
    }
    
    @objc func refreshAll() {
        
    }
    
    func setTitleAndYear(title: String, year: String) {
        _title = title
        _year = year
    }
    
    private func initialSetup() {
        Api.shared.page = 1
        getData()
        titleLabel.text = _title
        yearLabel.text = _year
    }
    
    private func getData() {
        let concurrent = DispatchQueue(label: "call top games and recent", attributes: .concurrent)
        
        concurrent.async {
            Api.shared.getGames { (res) in
                switch res {
                case .success((let data, _, _)):
                    self._games = data
                    self.collectionView.reloadData()
                case .failure(let err):
                    print(err)
                }
            }
            
            Api.shared.getRecentGames { res in
                switch res {
                case .success((let data, _, _)):
                    self._recentGames = data
                    self.tableView.reloadData()
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            
        }
    }
}

// MARK: Collection Extension
extension GamesListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        
        let games = _games[indexPath.row]
        cell.configure(content: games, type: .games)
        return cell
    }
    
    
}

extension GamesListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.height
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print(section, "ini section")
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK: Table Extension
extension GamesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _recentGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        let game = _recentGames[indexPath.row]
        cell.configure(game: game)
        return cell
    }
}

extension GamesListVC: UITableViewDelegate {
    
}
