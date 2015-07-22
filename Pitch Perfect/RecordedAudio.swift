//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Janaki Burugula on Jul/14/2015.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
