//
//  HomeViewController.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import SnapKit

protocol EpisodeViewDelegate {
    func playVideo(episodeNumber: String, episodes: [Episode])
}

class EpisodeView: UIView {
    //Views
    var episodeCollectionview: UICollectionView!
    //Variables
    var episodes = [Episode]()
    //Helpers
    var delegate: EpisodeViewDelegate!
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setting up views
    func setUpViews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.frame.size.height/3, height: self.frame.size.height/4)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 25
        episodeCollectionview = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        episodeCollectionview.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "episodeCollectionViewCell")
        episodeCollectionview.allowsSelection = true
        episodeCollectionview.backgroundColor = .white
        episodeCollectionview.delegate = self
        episodeCollectionview.dataSource = self
        
        self.addSubview(episodeCollectionview)
    }
    
    //MARK: - Setting up constraints
    func setUpConstraints() {
        episodeCollectionview.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

//MARK: - CollectionView delegate and data source methods
extension EpisodeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodeCollectionview.dequeueReusableCell(withReuseIdentifier: "episodeCollectionViewCell", for: indexPath) as! EpisodeCollectionViewCell
        cell.setUpValues(videoImage: episodes[indexPath.row].episodeThumb!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.playVideo(episodeNumber: String(indexPath.row), episodes: self.episodes)
    }
}
