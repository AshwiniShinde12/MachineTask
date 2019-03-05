//
//  Feeds.swift
//  AshwiniTaskApp
//
//  Created by Mac on 25/10/1940 Saka.
//  Copyright © 1940 Mac. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
       
        case id, name
    }
}
struct content {
    
}
