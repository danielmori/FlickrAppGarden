//
//  PostDetailsViewModel.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import Foundation
import SwiftUI

@Observable class PostDetailsViewModel {
    private(set) var loadedImage: Image?
    
    func imageLoaded(image: Image) {
        self.loadedImage = image
    }
}
