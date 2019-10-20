//
//  VideoCollectionViewCell.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import SnapKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    var videoImageview: UIImageView!
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Preparing for reuse
    override func prepareForReuse() {
        videoImageview.image = nil
        super.prepareForReuse()
    }
    
    //MARK: - Setting up views
    func setUpViews() {
        self.contentView.backgroundColor = Theme.sharedInstance.navigationColor()
        
        videoImageview = UIImageView()
        videoImageview.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(videoImageview)
    }
    
    //MARK: - Setting up constraints
    func setUpConstraints() {
        videoImageview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    //MARK: - Set up values
    func setUpValues(videoImage: String) {
        let addPrefixString = videoImage + ".jpg"
        self.videoImageview.image = UIImage(named: addPrefixString)
    }
}
