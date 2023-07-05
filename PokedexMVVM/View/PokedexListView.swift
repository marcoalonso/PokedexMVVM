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
    
    private let numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: numberOfColumns, spacing: 10) {
                    ForEach(viewModel.pokemonList, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonCellView(pokemon: pokemon, viewModel: viewModel)//Stack
                        }
                    }
                }.padding(20)
            }//Scroll
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


