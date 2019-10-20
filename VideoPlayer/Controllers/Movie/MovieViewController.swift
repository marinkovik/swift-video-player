//
//  HomeViewController.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

class MovieViewController: UIViewController {
    //Views
    var movieCollectionView: UICollectionView!
    var videoNavigationView: VideoNavigationView!
    var player = AVPlayer()
    var episodeView: EpisodeView!
    var playerController: AVPlayerViewController!
    //Helpers
    var pageControl: UIPageControl!
    var videoPathArray: [String]!
    var currentPlayingEpisode: Int!
    //Variables
    var shows = [Show]()
    var episodes = [Episode]()
    var currentPage = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { (make) in
//            print("Video ended")
            self.playerController.dismiss(animated: true, completion: nil)
            let playingEpisode = String(self.currentPlayingEpisode + 1)
            self.currentPlayingEpisode = self.currentPlayingEpisode + 1
            if (Int(playingEpisode)! < self.videoPathArray.count) {
                self.playEpisode(episodeNumber: playingEpisode, videoPathArray: self.videoPathArray)
            }
        }
        
        loadData()
        setUpViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movieCollectionView.reloadData()
    }
    
    //MARK: Setting up views
    func setUpViews() {
        self.view.backgroundColor = .white
        
        videoNavigationView = VideoNavigationView()
        videoNavigationView.setUpTitleName(title: shows[currentPage].showTitle!)
        videoNavigationView.backButton.removeFromSuperview()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        movieCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCollectionViewCell")
        movieCollectionView.isPagingEnabled = true
        movieCollectionView.allowsSelection = false
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = .white
        
        episodeView = EpisodeView(frame: self.view.frame)
        episodeView.episodes = self.shows[0].showEpisodes!
        episodeView.episodeCollectionview.reloadData()
        episodeView.episodeCollectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        episodeView.delegate = self
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = shows.count
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        self.view.addSubview(videoNavigationView)
        self.view.addSubview(movieCollectionView)
        self.view.addSubview(episodeView)
        self.view.addSubview(pageControl)
    }
    
    //MARK: Setting up constraints
    func setUpConstraints() {
        videoNavigationView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(80)
        }
        
        episodeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(4)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.episodeView.snp.top)
        }
        
        movieCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.videoNavigationView.snp.bottom)
            make.bottom.equalTo(self.pageControl.snp.top)
        }
    }
    
    //MARK: Getting the current page
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.self.frame.width)
        self.videoNavigationView.setUpTitleName(title: shows[currentPage].showTitle!)
        self.loadEpisodeViewData()
        self.pageControl.currentPage = self.currentPage
    }
    
    //MARK: Loading the episode data
    func loadEpisodeViewData() {
        episodeView.episodes = shows[currentPage].showEpisodes!
    
        self.episodeView.episodeCollectionview.reloadData()
        self.episodeView.episodeCollectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    //MARK: Play the episode
    func playEpisode(episodeNumber: String, videoPathArray: [String]) {
        
        let episodeNo = Int(episodeNumber)!
        let finalTitle = String(videoPathArray[episodeNo].dropLast(4))
        guard let path = Bundle.main.path(forResource: finalTitle, ofType: "mp4") else {
            print("Error loading" + finalTitle)
            return
        }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
        self.playerController = AVPlayerViewController()
        playerController.player = player
        print("Playing " + finalTitle)
        self.present(self.playerController, animated: true) {
            self.player.play()
        }
    }
}

//MARK: - CollectionView delegate and data source methods
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shows.count
    }
    
    //MARK: Cell for item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setUpValues(videoImage: shows[indexPath.row].showThumb!)
        return cell
    }
}

//MARK: - EpisodeView delegate methods
extension MovieViewController: EpisodeViewDelegate {
    func playVideo(episodeNumber: String, episodes: [Episode]) {
        self.currentPlayingEpisode = Int(episodeNumber)
        var videoPathArray = [String]()
        for episode in episodes{
            videoPathArray.append(episode.episodeVideo!)
        }
        self.videoPathArray = videoPathArray
        self.playEpisode(episodeNumber: episodeNumber, videoPathArray: videoPathArray)
    }
}

//MARK: - Geting info from plist
extension MovieViewController {
    //MARK: - Loading the data
    func loadData() {
        let path = Bundle.main.path(forResource: "TvShow", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let moviesDict = plist as! [[String: Any]]
        for movie in moviesDict {
            let episodes = movie["Episodes"] as! [[String: Any]]
            self.episodes = [Episode]()
            for episode in episodes {
                self.episodes.append(Episode(dict: episode))
            }
            shows.append(Show(dict: movie, episodes: self.episodes))
        }
    }
}
