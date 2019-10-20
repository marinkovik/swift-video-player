//
//  VideoCollectionViewCell.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
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
        self.videoImageview.image = nil
        super.prepareForReuse()
    }
    
    //MARK: - Setting up views
    func setUpViews() {
        self.contentView.backgroundColor = .white
        
        videoImageview = UIImageView()
        videoImageview.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(videoImageview)
    }
    
    //MARK: - Setting up constraints
    func setUpConstraints() {
        videoImageview.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(200)
            make.left.equalTo(self.contentView).offset(200)
            make.right.equalTo(self.contentView).offset(-200)
            make.bottom.equalTo(self.contentView).offset(-200)
        }
    }
        
    //MARK: - Set up values
    func setUpValues(videoImage: String) {
        self.videoImageview.image = UIImage(named: videoImage)
    }
}
