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
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var footer: UIView!
    
    private var _categoeries: [Category] = []
    private var _currentPage: Int = 1
    
    private var gradientView = GradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradientView()
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getData(page: _currentPage)
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        _currentPage += 1
        getData(page: _currentPage)
    }
    
    @IBAction func prevPage(_ sender: UIButton) {
        _currentPage -= 1
        getData(page: _currentPage)
    }
    
    private func setUpGradientView() {
        view.insertSubview(gradientView, belowSubview: header)
        gradientView.direction = .horizontal
        gradientView.colors = [
            #colorLiteral(red: 0.1098039216, green: 0.09803921569, blue: 0.1803921569, alpha: 1),
            #colorLiteral(red: 0.1254901961, green: 0.1333333333, blue: 0.2078431373, alpha: 1)
        ]
        gradientView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func getData(page: Int) {
        Api.shared.page = page
        Api.shared.getCategory { (res) in
            switch res {
            case .success(let data):
                DispatchQueue.main.async {
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
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _categoeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        
        let category = _categoeries[indexPath.row]
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
        let rowCount: CGFloat = CGFloat(_categoeries.count / 2)
        let cellWidth = (view.frame.size.width / 2 - 20) * rowCount
        let top: CGFloat = (collectionView.frame.size.height - cellWidth) / 3
        
        return UIEdgeInsets(top: top, left: 10, bottom: 0, right: 10)
    }
}
