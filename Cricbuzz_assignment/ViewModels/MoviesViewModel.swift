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
    {
        didSet
        {
            dataSource.refreshSectionData(isSearchActive: !isSearchTextEmpty, currentlyExpandedSection: currentlyExpandedSection)
        }
    }
    
    var isSearchTextEmpty: Bool
    {
        return searchBarText.isEmpty
    }

    var currentlyExpandedSection: Int?

    init(movieNetworkManager: NetworkManagerProtocol)
    {
        self.searchBarText = kEmptyString
        dataSource = MovieDataSource(networkManager: movieNetworkManager)
        dataSource.refreshSectionData()
    }

    func numberOfSections() -> Int
    {
        return dataSource.sectionData.count
    }

    func numberOfRowsInSection(section: Int) -> Int
    {
        if section != currentlyExpandedSection && isSearchTextEmpty
        {
            return .zero
        }
        else if dataSource.sectionData[section].sectionType == .allMovies || !isSearchTextEmpty
        {
            let moviesList = dataSource.filteredData.first?.movies ?? []
            return moviesList.count
        }
        else
        {
            return dataSource.filteredData.count
        }
    }
    
    func isSectionCollapsed(section: Int) -> Bool
    {
        return dataSource.sectionData[section].isCollapsed
    }

    func titleForHeaderInSection(section: Int) -> String
    {
        return dataSource.sectionData[section].title
    }
    
    func getDataForRow(for sectionType: SectionType, at indexPath: IndexPath) -> Any
    {
        if sectionType == .allMovies
        {
            return dataSource.filteredData.first?.movies[indexPath.row] as Any
        }
        else
        {
            return dataSource.filteredData[indexPath.row]
        }
    }
    
    func getSectionType(for section: Int) -> SectionType
    {
        let section = dataSource.sectionData[section]
        return section.sectionType
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

    func filterMovies(section: Int?)
    {
        if let expandedSection = currentlyExpandedSection, isSearchTextEmpty
        {
            let sectionType = getSectionType(for: expandedSection)
            dataSource.filterMovies(text: searchBarText, attribute: sectionType)
        }
        else if let section
        {
            let sectionType = getSectionType(for: section)
            dataSource.filterMovies(text: searchBarText, attribute: sectionType)
        }
        else
        {
            dataSource.filterMovies(text: searchBarText, attribute: .allMovies)
        }
    }
    
    func fetchMovies(comp: @escaping ()->Void)
    {
        dataSource.fetchMovies(comp: comp)
    }
}

