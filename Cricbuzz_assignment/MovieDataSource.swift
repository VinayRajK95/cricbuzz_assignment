//
//  MovieDataSource.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import Foundation

class MovieDataSource
{
    enum Section: Int, CaseIterable
    {
        case actors
        case genre
        case director
        case year
        case allMovies
        
        var title: String
        {
            switch self {
                case .actors: return "Actors"
                case .genre: return "Genre"
                case .director: return "Director"
                case .year: return "Year"
                case .allMovies: return "All Movies"
            }
        }
        
        var cellIdentifier: String
        {
            switch self {
                case .actors: fallthrough
                case .genre: fallthrough
                case .director: fallthrough
                case .year: return "MovieTitleCell"
                case .allMovies: return "MovieCell"
            }
        }
    }
    
    struct CollapsibleSection
    {
        var title: String
        var isCollapsed: Bool
    }
    
    private let networkManager: NetworkManagerProtocol
    
    private var movies: [Movie] = []
    
    var filteredData: [GroupedMovies] = []
    
    var currentlyExpandedSection: Int?

    var sectionData: [CollapsibleSection] = Section.allCases.map { .init(title: $0.title, isCollapsed: true)
    }
    
    init(networkManager: NetworkManagerProtocol)
    {
        self.networkManager = networkManager
    }

    func filterMovies(text: String, attribute: Section)
    {
        var groupedMovies: [String: [Movie]] = [:]
        switch attribute
        {
            case .year:
                groupedMovies = groupMoviesByList(\.yearList)
            case .actors:
                groupedMovies = groupMoviesByList(\.actorsList)
            case .director:
                groupedMovies = groupMoviesByList(\.directorList)
            case .genre:
                groupedMovies = groupMoviesByList(\.genreList)
            case .allMovies:
                groupedMovies = ["allMovies": movies]
        }
        let sortedKeys = groupedMovies.keys.sorted()

        filteredData =  sortedKeys.compactMap { key in
            var movies = groupedMovies[key] ?? []
            if !text.isEmpty
            {
                movies = movies.filter
                { $0.actors.localizedCaseInsensitiveContains(text) ||
                    $0.title.localizedCaseInsensitiveContains(text) || $0.genre.localizedCaseInsensitiveContains(text) || $0.director.localizedCaseInsensitiveContains(text) || $0.year.localizedCaseInsensitiveContains(text)
                }
            }
            
            return !movies.isEmpty ? GroupedMovies(identifier: key, movies: movies) : nil
        }
    }
    
    private func groupMoviesByList(_ listKeyPath: KeyPath<Movie, [String]>) -> [String: [Movie]]
    {
        var groupedMovies: [String: [Movie]] = [:]
        for movie in movies {
            let list = movie[keyPath: listKeyPath]
            for item in list {
                if var group = groupedMovies[item] {
                    group.append(movie)
                    groupedMovies[item] = group
                } else {
                    groupedMovies[item] = [movie]
                }
            }
        }
        return groupedMovies
    }
    
    func fetchMovies(comp: @escaping ()->Void)
    {
        networkManager.fetchMoviesModel { [unowned self] (result: Result<[Movie], JSONError>) in
            switch result
            {
                case .success(let movies):
                    self.movies = movies
                    comp()
                case .failure(let error):
                    switch error
                    {
                        case .fileNotFound:
                            debugPrint("File not found error")
                        case .decodingFailed:
                            debugPrint("Decoding failed error")
                    }
            }
        }
    }
}




// actors separated by each value
// search option should be displaying only movie list
// Github link
// protocol based call
// refactor cellForRowAt at movie list
// change to tap gesture
// refactor/modify
