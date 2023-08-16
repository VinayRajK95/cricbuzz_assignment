//
//  MoviesViewModel.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import Foundation

class MoviesViewModel
{
    typealias SectionType = MovieDataSource.Section
    private var dataSource: MovieDataSource
    private let kEmptyString = ""
    var searchBarText: String
    
    var isSearchTextEmpty: Bool
    {
        return searchBarText.isEmpty
    }

    var currentlyExpandedSection: Int?

    init(movieNetworkManager: NetworkManagerProtocol)
    {
        dataSource = MovieDataSource(networkManager: movieNetworkManager)
        self.searchBarText = kEmptyString
    }

    func numberOfSections() -> Int
    {
        return searchBarText.isEmpty ? dataSource.sectionData.count : 1
    }

    func numberOfRowsInSection(section: Int) -> Int
    {
        if !searchBarText.isEmpty
        {
            // Show the number of filtered rows when there's text in the search bar
            return dataSource.filteredData.count
        }
        else
        {
            if section != currentlyExpandedSection
            {
                return .zero
            }
            else if isAllMoviesSection(section: section)
            {
                let moviesList = dataSource.filteredData.first?.movies ?? []
                return moviesList.count
            }
            else
            {
                return dataSource.filteredData.count
            }
        }
    }
    
    func isAllMoviesSection(section: Int) -> Bool
    {
        let allMoviesSection: Int = SectionType.allMovies.rawValue
        return section == allMoviesSection
    }

    func titleForHeaderInSection(section: Int) -> String
    {
        return dataSource.sectionData[section].title
    }
    
    func getDataForRow(for sectionType: SectionType, at indexPath: IndexPath) -> Any
    {
        if sectionType == .allMovies
        {
            let movie = dataSource.filteredData.first?.movies[indexPath.row]
            return movie as Any
        }
        else
        {
            let data = dataSource.filteredData[indexPath.row]
            return data.identifier
        }
    }
    
    func getSectionType(for section: Int) -> SectionType?
    {
        return SectionType.init(rawValue: section)
    }
    
    func movieDetailForRow(at indexPath: IndexPath) -> GroupedMovies
    {
        return dataSource.filteredData[indexPath.row]
    }

    func toggleSection(sectionIndex: Int)
    {
        if currentlyExpandedSection == sectionIndex
        {
            dataSource.sectionData[sectionIndex].isCollapsed = true
            currentlyExpandedSection = nil
        }
        else
        {
            dataSource.sectionData[sectionIndex].isCollapsed = false
            if let previousExpandedSection = currentlyExpandedSection
            {
                dataSource.sectionData[previousExpandedSection].isCollapsed = true
            }
            currentlyExpandedSection = sectionIndex
        }
    }

    func filterMovies(section: SectionType)
    {
        dataSource.filterMovies(text: searchBarText, attribute: section)
    }
    
    func fetchMovies(comp: @escaping ()->Void)
    {
        dataSource.fetchMovies(comp: comp)
    }
}

