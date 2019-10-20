//
//  Episode.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import Foundation

class Episode: NSObject {
    var episodeNo: Int?
    var episodeTitle: String?
    var episodeThumb: String?
    var episodeVideo: String?
    
    init(dict: [String: Any]) {
        self.episodeNo = dict["Episode Number"] as? Int
        self.episodeTitle = dict["Episode Title"] as? String
        self.episodeThumb = dict["Episode Thumbnail"] as? String
        self.episodeVideo = dict["Episode Video Path"] as? String
    }
}
