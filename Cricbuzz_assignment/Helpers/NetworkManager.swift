//
//  NetworkManager.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject
{
    func fetchMoviesModel(from: String, completion: @escaping (Result<[Movie], JSONError>) -> Void)
}

enum JSONError: Error
{
    case fileNotFound
    case decodingFailed
}


class MovieNetworkManager: NetworkManagerProtocol
{
    func fetchMoviesModel(from: String, completion: @escaping (Result<[Movie], JSONError>) -> Void)
    {
        // API logic can be implemented here
    }
}

class MovieLocalNetworkManager: NetworkManagerProtocol
{
    enum Constants
    {
        static let jsonFileExtension = "json"
    }
    func fetchMoviesModel(from: String, completion: @escaping (Result<[Movie], JSONError>) -> Void)
    {
        DispatchQueue.global(qos: .background).async
        {
            guard let fileURL = Bundle.main.url(forResource: from, withExtension: Constants.jsonFileExtension)
            else
            {
                completion(.failure(.fileNotFound))
                return
            }
            do
            {
                let jsonData = try Data(contentsOf: fileURL)
                let movies: [Movie] = try JsonParser().parseJSON(from: jsonData)
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
