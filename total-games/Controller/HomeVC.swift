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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var footer: UIView!
    
    private var categoeries: [Category] = []
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getData(page: currentPage)
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        currentPage += 1
        getData(page: currentPage)
    }
    
    @IBAction func prevPage(_ sender: UIButton) {
        currentPage -= 1
        getData(page: currentPage)
    }
    
    
    private func getData(page: Int) {
        Api.shared.column = 2
        Api.shared.page = page
        Api.shared.getCategory { (res) in
            switch res {
            case .success(let data):
                DispatchQueue.main.async {
                    self.categoeries = data.0
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
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoeries.count
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
        let rowCount: CGFloat = CGFloat(categoeries.count / 2)
        let cellWidth = (view.frame.size.width / 2 - 20) * rowCount
        var top: CGFloat!

        if cellWidth < collectionView.frame.size.height {
            top = (collectionView.frame.size.height - cellWidth) / 2
        } else {
            top = 10
        }
        
        return UIEdgeInsets(top: top, left: 10, bottom: 0, right: 10)
    }
}
