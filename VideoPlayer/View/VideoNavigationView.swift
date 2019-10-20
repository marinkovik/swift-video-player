//
//  VideoNavigationView.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import SnapKit

protocol VideoNavigationViewDelegate {
    func goBack()
}

class VideoNavigationView: UIView {
    var backButton: UIButton!
    var titleLabel: UILabel!
    var separatorLabel: UILabel!
    //Helpers
    var delegate: VideoNavigationViewDelegate?
    
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
        self.backgroundColor = Theme.sharedInstance.navigationColor()

        backButton = UIButton()
        backButton.setImage(UIImage(named: "back_button"), for: .normal)
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Theme.sharedInstance.regularFont(), size: 30)
        
        separatorLabel = UILabel()
        separatorLabel.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(separatorLabel)
    }
    
    //MARK: - Setting up constraints
    func setUpConstraints() {
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.edges.equalTo(self)
        }
        
        separatorLabel.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    //MARK: - Set up title name
    func setUpTitleName(title: String) {
        titleLabel.text = title
    }
    
    //MARK: - Go inside
    @objc func popViewController() {
        self.delegate!.goBack()
    }
}
