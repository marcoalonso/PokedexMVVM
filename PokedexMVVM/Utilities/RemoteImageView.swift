//
//  RemoteImageView.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 04/07/23.
//

import Foundation

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    func load(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}


struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        if let image = image {
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "pokemon").resizable()
        }
        
    }
}


struct PokemonRemoteImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURL: urlString) }
    }
}

