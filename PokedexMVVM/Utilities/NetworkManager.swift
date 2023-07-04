//
//  NetworkManager.swift
//  PokedexMVVM
//
//  Created by Marco Alonso Rodriguez on 04/07/23.
//

import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    private override init() {}
    
    func getListOfPokemon(completed: @escaping (Result<[PokemonModel], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data?.parseData(removeString: "null,") else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([PokemonModel].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("Debug: decoding error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
