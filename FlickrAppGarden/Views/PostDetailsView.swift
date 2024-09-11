//
//  PostDetailsView.swift
//  FlickrAppGarden
//
//  Created by Daniel Mori on 11/09/24.
//

import SwiftUI
import DMCachedImage

struct PostDetailsView: View {
    var post: Post
    @State private var viewModel: PostDetailsViewModel

    init(post: Post, viewModel: PostDetailsViewModel) {
        self.post = post
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(10)
                .foregroundColor(.gray)
                .padding()
            if let url = URL(string: post.media.image) {
                ScrollView {
                    VStack(alignment: .leading) {
                        DMCachedImage(url: url, transaction: .init(animation: .smooth)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .onAppear {
                                        viewModel.imageLoaded(image: image)
                                    }
                            case .failure(_):
                                Image(systemName: "exclamationmark.triangle.fill")
                            @unknown default:
                                Image(systemName: "questionmark")
                            }
                        }
                        .cornerRadius(10)
                        .accessibilityAddTraits(.isImage)
                        
                        Text(post.title)
                            .font(.title)
                            .accessibilityAddTraits(.isHeader)
                        
                        Label(post.authorName, systemImage: "person.circle")
                            .font(.headline)
                            .accessibilityLabel("Username from who posted the photo")
                            .accessibilityValue("Photo posted by \(post.authorName)")
                        
                        HStack {
                            Label("Width: \(post.width)px", systemImage: "arrow.left.and.right")
                                .accessibilityValue("Width of \(post.width) pixels")
                                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                            Label("Height \(post.height)px", systemImage: "arrow.up.and.down")
                                .accessibilityValue("Height of \(post.height) pixels")
                                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        }
                        
                        Divider()
                            .padding([.top], 20)
                        
                        Text("Top 5 tags")
                            .font(.headline)
                            .accessibilityAddTraits(.isStaticText)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.adaptive(minimum: 30))], spacing: 3) {
                                let tagsCount = min(post.tagsArray.count-1, 4)
                                ForEach(post.tagsArray[0...tagsCount], id:\.self) { tag in
                                    Text("#\(tag)")
                                        .font(.caption)
                                        .padding(4)
                                        .fontWeight(.bold)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(4)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        if let image = viewModel.loadedImage {
                            ShareLink(item: image, preview: SharePreview("Photo taken by: \(post.authorName)", image: image))
                                .frame(width: 200.0, height: 40.0)
                                .background(.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        
                    }
                }
            } else {
                // show error not being able to generate URL
            }
        }.padding()
    }
}

#Preview("Main State") {
    PostDetailsView(post: FlickrResponse.mock.first!, viewModel: PostDetailsViewModel())
}

#Preview("Brazilian Portuguese") {
    PostDetailsView(post: FlickrResponse.mock.first!, viewModel: PostDetailsViewModel())
        .environment(\.locale, .init(identifier: "pt-br"))
}
