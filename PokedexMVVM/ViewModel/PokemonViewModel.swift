//
//  PokemonViewModel.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 13/06/23.
//

import Foundation
import SwiftUI


class PokemonViewModel: ObservableObject {
    @Published var listPokemon = [PokemonModel]()
    @Published var fileterdPokemon = [PokemonModel]()
    @Published var alertItem: AlertItem?
    var colors: [Color] = [.red, .gray, .green, .yellow, .blue, .pink, .brown]
    
    init() {
        getListPokemon()
    }
    
    func getListPokemon() {
        NetworkManager.shared.getListOfPokemon { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let listPokemon):
                    print("Debug: listPokemon \(listPokemon.count)")
                    self.listPokemon = listPokemon
                    self.fileterdPokemon = listPokemon
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .decodingError:
                        self.alertItem = AlertContext.decodingError
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }//result
            }//Dispatch
        }//in
    }//func getList
    
    func getColorBasedOnType(type: String) -> Color {
        switch type {
        case "poison":
            return .purple
        case "fire":
            return .red
        case "water":
            return .blue
        case "bug", "grass":
            return .green
        case "flying":
            return .mint
        case "normal":
            return .pink
        case "electric":
            return .yellow
        case "ground":
            return .brown
        case "fairy","psychic", "dragon":
            return .orange
        case "fighting":
            return .gray
        case "ice", "steel":
            return .teal
        default:
            return .white
        }
    }
    
    func filerPokemon(name: String) {
        if name.isEmpty {
            fileterdPokemon = listPokemon
        } else {
            fileterdPokemon = listPokemon.filter({ pokemon in
                pokemon.name.lowercased().contains(name.lowercased())
            })
        }
    }
    
}
