//
//  MovieDataSource.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import Foundation

class MovieDataSource
{
    enum Constants
    {
        static let moviesJsonFileName = "movies"
        static let allMoviesKey = "allMovies"
    }
    
    enum Section: CaseIterable
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
        var sectionType: Section
        var isCollapsed: Bool = true
    }
    
    private let networkManager: NetworkManagerProtocol
    
    private var movies: [Movie] = []
    
    var filteredData: [GroupedMovies] = []

    var sectionData: [CollapsibleSection] = []
    
    init(networkManager: NetworkManagerProtocol)
    {
        self.networkManager = networkManager
    }
    
    func refreshSectionData(isSearchActive: Bool = false, currentlyExpandedSection: Int? = nil)
    {
        if isSearchActive
        {
            let allMoviesSection  = Section.allMovies
            sectionData = [.init(title: allMoviesSection.title, sectionType: allMoviesSection, isCollapsed: false)]
        }
        else
        {
            sectionData = Section.allCases.map { .init(title: $0.title, sectionType: $0, isCollapsed: true)
            }
            if let expandedSection = currentlyExpandedSection
            {
                sectionData[expandedSection].isCollapsed = false
            }
        }
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
                groupedMovies = [Constants.allMoviesKey: movies]
        }
        
        // Sort the grouped list and also filter by search text conditionally
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
        // Grouping as per the actor/genre/director
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
        networkManager.fetchMoviesModel(from: Constants.moviesJsonFileName)
        { [weak self] (result: Result<[Movie], JSONError>) in
            switch result
            {
                case .success(let movies):
                    self?.movies = movies
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
