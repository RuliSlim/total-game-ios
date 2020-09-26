//
//  DetailVC.swift
//  total-games
//
//  Created by Ruli on 13/07/20.
//  Copyright © 2020 Ruli. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    // MARK: -TopBody
    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var image: CardImage!
    @IBOutlet weak var slideShowControl: UIPageControl!
    
    // MARK: -Body
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerBody: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutGame: UILabel!
    @IBOutlet weak var detailsGame: UIStackView!
    @IBOutlet weak var platforms: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var developer: UILabel!
    
    // MARK: -LowerBody
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var similarLabel: UILabel!
    
    // MARK: -Data
    private var _game: Game!
    private var _photos: [Screenshot]!
    private var _similarGames: [Games] = []
    private var timer: Timer?
    private var currentPhoto: Int = 0
    private let concurrent = DispatchQueue(label: "call game detail and screen", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
        self.fetchData()
        self.setupCollectionView()
    }
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            aboutGame.isHidden = false
            detailsGame.isHidden = true
            setupAbout()
        default:
            aboutGame.isHidden = true
            detailsGame.isHidden = false
            setupDetails()
        }
        print(segmentedControl.selectedSegmentIndex, "ini ke print")
    }
    
    private func initialSetup() {
        let edge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwipe))
        edge.edges = .left
        view.addGestureRecognizer(edge)
    }
    
    @objc func screenEdgeSwipe(_ recognize: UIScreenEdgePanGestureRecognizer) {
        if recognize.state == .recognized {
            self.goBack()
        }
    }
    
    private func fetchData() {
        concurrent.async {
            self.getGameDetail()
        }
        concurrent.async {
            self.getScreenshot()
        }
        concurrent.async {
            self.getSimilarGame()
        }
    }
    
    private func getGameDetail() {
        Api.shared.getDetailGame { res in
            switch res {
            case .success(let data):
                self.concurrent.sync {
                    self._game = data
                    self.setupAbout()
                }
            case .failure(let error):
                print(error, "ini err detail")
            }
        }
    }
    
    private func getScreenshot() {
        Api.shared.getScreenshot { res in
            switch res {
            case .success(let data):
                self.concurrent.sync {
                    self._photos = data
                    self.setupPhotos()
                }
            case .failure(let error):
                print(error, "ini error scren")
            }
        }
    }
    
    private func getSimilarGame() {
        Api.shared.getSimilarGame { res in
            switch res {
            case .success(let data):
                self.concurrent.sync {
                    self._similarGames = data
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error, "ini error similarGAme")
            }
        }
    }
    
    private func setupDetails() {
        publisher.text = _game.getPub()
        developer.text = _game.getDev()
        genre.text = _game.getGenre()
        website.text = _game.website
        releaseDate.text = _game.tba ? "TBA" : _game.released
        platforms.text = _game.getPlatform()
        
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: containerBody.bottomAnchor).isActive = true
    }
    
    private func setupAbout() {
        aboutGame.text = _game.description?.description()
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: aboutGame.bottomAnchor).isActive = true
        
        titleGame.text = _game.name
        similarLabel.text = "Games like" + _game.name
    }
    
    private func setupPhotos() {
        slideShowControl.numberOfPages = _photos.count
        
        let displayedPhoto = _photos[currentPhoto].image
        image.load.request(with: displayedPhoto)
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown(_ sender: Timer) {
        if currentPhoto != _photos.count - 1 {
            currentPhoto += 1
        } else {
            currentPhoto = 0
        }
        let displayedPhoto = _photos[currentPhoto].image
        image.load.request(with: displayedPhoto)
        slideShowControl.currentPage = currentPhoto
    }
    
    // MARK: -Setting collectionView
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CardCell.nib(), forCellWithReuseIdentifier: CardCell.identifier)
    }
}

// MARK: -Collection of similar games
extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _similarGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        let game = _similarGames[indexPath.row]
        cell.configure(content: game, type: .games)
        return cell
    }
    
}

extension DetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Api.shared.game_id = _similarGames[indexPath.row].id
        timer?.invalidate()
        currentPhoto = 0
        self.fetchData()
    }
}

extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.height
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
