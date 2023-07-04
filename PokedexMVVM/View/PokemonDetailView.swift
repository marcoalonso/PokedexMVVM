//
//  PokemonDetailView.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 04/07/23.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonModel
    var body: some View {
        VStack {
            PokemonRemoteImage(urlString: pokemon.imageUrl)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: MockData.pokemon)
    }
}
