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
                    ForEach(viewModel.fileterdPokemon, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonCellView(pokemon: pokemon, viewModel: viewModel)//Stack
                        }
                    }
                }.padding(20)
            }//Scroll
            .searchable(text: $pokemonToSearch, prompt: "Search pokemon")
            .onChange(of: pokemonToSearch, perform: { namePokemon in
                withAnimation {
                    viewModel.filerPokemon(name: namePokemon)
                }
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


