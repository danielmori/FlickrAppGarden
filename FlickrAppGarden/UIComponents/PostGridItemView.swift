//
//  PostGridItemView.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import SwiftUI
import DMCachedImage

struct PostGridItemView: View {
    let url: URL?
    
    var body: some View {
        if let url = url {
            DMCachedImage(url: url, transaction: .init(animation: .smooth)) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                case .empty:
                    ProgressView()
                case .failure(_):
                    Image(systemName: "exclamationmark.triangle.fill")
                @unknown default:
                    Image(systemName: "questionmark")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fill)
            .cornerRadius(10.0)
        }
    }
}

#Preview {
    PostGridItemView(url: FlickrResponse.mock.first!.url)
}
