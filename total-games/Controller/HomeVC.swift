//
//  ViewController.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit
import GradientView

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var loading: UIView!
    
    private var refreshControl = UIRefreshControl()
    private var _categoeries: [Category] = []
    private var _currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        _currentPage += 1
        getData(page: _currentPage)
    }
    
    @IBAction func prevPage(_ sender: UIButton) {
        _currentPage -= 1
        getData(page: _currentPage)
    }
    
    @objc func refreshVC() {
        getData(page: _currentPage)
        collectionView.refreshControl?.endRefreshing()
    }
    
    private func initialSetup() {
        if _categoeries.count > 0 {
            loading.isHidden = true
        }
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getData(page: _currentPage)
        refreshControl.addTarget(self, action: #selector(refreshVC), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func getData(page: Int) {
        Api.shared.page = page
        Api.shared.getCategory { (res) in
            switch res {
            case .success(let data):
                DispatchQueue.main.async {
                    self.loading.isHidden = true
                    self._categoeries = data.0
                    self.collectionView.reloadData()
                    if data.1 != nil {
                        self.nextButton.isHidden = false
                    } else {
                        self.nextButton.isHidden = true
                    }
                    if data.2 != nil {
                        self.prevButton.isHidden = false
                    } else {
                        self.prevButton.isHidden = true
                    }
                }
            case .failure(let err):
                print(err, "ini eroor")
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
                if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            cell.didTapped()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
                if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            cell.dropShadow()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        Api.shared.category = _categoeries[indexPath.row].id
        guard let gameListVC = storyboard?.instantiateViewController(withIdentifier: "GamesListVC") as? GamesListVC else { return }
        
        let date = Date()
        let calendar = Calendar.current
        Api.shared.year = calendar.component(.year, from: date)
        
        let name = _categoeries[indexPath.row].name
        gameListVC.setTitleAndYear(title: "\(name) Games", year: "Top Games")
        self.presentNext(gameListVC)
    }
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _categoeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        
        let category = _categoeries[indexPath.row]
        cell.configure(content: category, type: .category)
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width / 2 - 30
        let height = collectionView.frame.size.height / 3 - 15
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12.75, left: 12.75, bottom: 0, right: 12.75)
    }
}
