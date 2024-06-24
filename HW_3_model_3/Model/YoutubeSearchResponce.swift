//
//  YoutubeSearchResponce.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 04/06/2024.
//

import Foundation


struct YoutubeSearchResponce: Codable {
        
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}


