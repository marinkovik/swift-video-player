//
//  Show.swift
//  VideoPlayer
//
//  Created by Slobodan Marinkovikj on 7/16/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import Foundation

class Show: NSObject {
    var showId: Int?
    var showTitle: String?
    var showSmallDescription: String?
    var showDescription: String?
    var showThumb: String?
    var showEpisodes: [Episode]?
    
    init(dict: [String: Any], episodes: [Episode]) {
        self.showId = dict["Show_Id"] as? Int
        self.showTitle = dict["Show_Title"] as? String
        self.showSmallDescription = dict["Show_Small_Desc"] as? String
        self.showDescription = dict["Show_Desc"] as? String
        self.showThumb = dict["Show_Thumb"] as? String
        self.showEpisodes = episodes
    }
}
