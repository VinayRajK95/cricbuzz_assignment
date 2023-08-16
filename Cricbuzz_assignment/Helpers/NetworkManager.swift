//
//  NetworkManager.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject
{
    func fetchMoviesModel(completion: @escaping (Result<[Movie], JSONError>) -> Void)
}

enum JSONError: Error
{
    case fileNotFound
    case decodingFailed
}

class MovieLocalNetworkManager: NetworkManagerProtocol
{
    func fetchMoviesModel(completion: @escaping (Result<[Movie], JSONError>) -> Void)
    {
        DispatchQueue.global(qos: .background).async
        {
            guard let fileURL = Bundle.main.url(forResource: "movies", withExtension: "json")
            else
            {
                completion(.failure(.fileNotFound))
                return
            }
            do
            {
                let jsonData = try Data(contentsOf: fileURL)
                let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
                completion(.success(movies))
            }
            catch
            {
                print("Error: \(error)")
                    completion(.failure(.decodingFailed))
            }
        }
    }
}


class MovieNetworkManager: NetworkManagerProtocol
{
    func fetchMoviesModel(completion: @escaping (Result<[Movie], JSONError>) -> Void)
    {
        // API logic can be implemented here
    }
}
