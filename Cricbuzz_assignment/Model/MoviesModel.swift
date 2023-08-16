//
//  MoviesModel.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 11/08/23.
//

import Foundation

struct Movie: Decodable
{
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards, poster: String
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let boxOffice, production: String?
    
    var actorsList: [String]
    {
        return parseList(from: actors)
    }
    
    var genreList: [String]
    {
        return parseList(from: genre)
    }
    
    var directorList: [String]
    {
        return parseList(from: director)
    }
    
    var yearList: [String]
    {
        return parseList(from: year, with: "-")
    }
    
    enum CodingKeys: String, CodingKey
    {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case ratings = "Ratings"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case boxOffice = "BoxOffice"
        case production = "Production"
    }
    
    struct Rating: Codable {
        let source: Source
        let value: String
        
        enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
        
        enum Source: String, Codable {
            case internetMovieDatabase = "Internet Movie Database"
            case metacritic = "Metacritic"
            case rottenTomatoes = "Rotten Tomatoes"
        }
    }
    
    private func parseList(from string: String,with separator: String = ",") -> [String]
    {
        return string.split(separator: separator).map { $0.trimmingCharacters(in: .whitespaces) }
    }
}

struct GroupedMovies
{
    let identifier: String
    let movies: [Movie]
}
