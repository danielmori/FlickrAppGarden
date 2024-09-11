//
//  Media.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import Foundation

struct Media: Decodable {
    let image: String
    private enum CodingKeys: String, CodingKey {
        case image = "m"
    }
}
