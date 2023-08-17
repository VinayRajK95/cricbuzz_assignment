//
//  JsonParser.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 17/08/23.
//

import Foundation

struct JsonParser
{
    func parseJSON<T: Decodable>(from data: Data) throws -> T
    {
        let model = try JSONDecoder().decode(T.self, from: data)
        return model
    }
}
