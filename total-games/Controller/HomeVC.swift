//
//  ViewController.swift
//  total-games
//
//  Created by Ruli on 09/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoeries: [Category] = [
        Category(id: 1, image: "pc", name: "PC", games: 234),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455),
        Category(id: 2, image: "pc", name: "PS4", games: 2455)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
//            cell.didTapped()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
//            cell.setUpCardBody()
//        }
//    }
    
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
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
//        cell.didTapped()
//    }
    
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        
        let category = categoeries[indexPath.row]
        cell.configure(with: category)
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width / 2 - 20
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.5, left: 12.5, bottom: 12.5, right: 12.5)
    }
}
