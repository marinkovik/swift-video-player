//
//  Theme.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 10/20/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//
import Foundation
import UIKit

class Theme {
    static let sharedInstance = Theme()
    
    //MARK: Fonts
    func regularFont() -> String {
        return "Cabin-Bold"
    }
    
    //MARK: Colors
    func navigationColor() -> UIColor {
        return UIColor(red: 254.0/255.0, green: 255.0/255.0, blue: 252.0/255.0, alpha: 0.9)
    }
}
