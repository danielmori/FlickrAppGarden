//
//  FlickrAppGardenApp.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import SwiftUI

@main
struct FlickrAppGardenApp: App {
    var body: some Scene {
        WindowGroup {
            let service = FlickrService()
            let viewModel = SearchableGridViewModel(service: service)
            NavigationStack {
                SearchableGridView(viewModel: viewModel)
            }
        }
    }
}
