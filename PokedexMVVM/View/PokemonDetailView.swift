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
        VStack(spacing: 20.0) {
            PokemonRemoteImage(urlString: pokemon.imageUrl)
                .shadow(radius: 12)
                .frame(maxHeight: 300)
            
            Text(pokemon.description)
                .font(.system(size: 28))
                .lineLimit(4)
            
            VStack(spacing: 20.0) {
                Text("Type: \(pokemon.type)")
                    .font(.title2)
                
                HStack(spacing: 15.0) {
                    Text("Attack: \(pokemon.attack)")
                        .foregroundColor(.red)
                        
                    
                    Text("Defense: \(pokemon.defense)")
                        .foregroundColor(.green)
                }
                .font(.title2)
                .bold()
            }
            
            Spacer()
        }.padding(15)
            .navigationTitle(pokemon.name)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: MockData.pokemon)
    }
}
