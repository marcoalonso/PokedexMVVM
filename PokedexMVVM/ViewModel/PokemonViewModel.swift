//
//  PokemonViewModel.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 13/06/23.
//

import Foundation
import SwiftUI


class PokemonViewModel: ObservableObject {
    @Published var pokemonList = [PokemonModel]()
    @Published var alertItem: AlertItem?
    
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
                    self.pokemonList = listPokemon
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
    
}
