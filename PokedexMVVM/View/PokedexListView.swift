//
//  ContentView.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 13/06/23.
//

import SwiftUI

struct PokedexListView: View {
    @StateObject var viewModel = PokemonViewModel()
    @State private var pokemonToSearch = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.pokemonList, id: \.id) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        HStack(spacing: 20.0) {
                            PokemonRemoteImage(urlString: pokemon.imageUrl)
                                .frame(width: 80, height: 80)
                                .shadow(radius: 12)
                            
                            Text(pokemon.name)
                                .font(.title)
                        }
                    }
                }
            }
            .searchable(text: $pokemonToSearch, prompt: "Search pokemon")
            .onChange(of: pokemonToSearch, perform: { newValue in
                //TODO: -
            })
            .navigationBarTitle("Pokedex", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexListView()
    }
}
