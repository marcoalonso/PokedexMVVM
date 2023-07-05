//
//  PokemonCellView.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 04/07/23.
//

import SwiftUI

struct PokemonCellView: View {
    
    let pokemon: PokemonModel
    let viewModel: PokemonViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.getColorBasedOnType(type: pokemon.type))
                .cornerRadius(25)
            VStack {
                PokemonRemoteImage(urlString: pokemon.imageUrl)
                    .frame(width: 100, height: 100)
                
                Text(pokemon.name)
                    .font(.body)
                    .foregroundColor(.white)
            }
        }
    }
}
