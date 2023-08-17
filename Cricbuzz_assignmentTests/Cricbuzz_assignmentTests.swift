//
//  Cricbuzz_assignmentTests.swift
//  Cricbuzz_assignmentTests
//
//  Created by kiran raj on 11/08/23.
//

import XCTest
@testable import Cricbuzz_assignment

class MoviesViewModelTests: XCTestCase
{
    typealias SectionType = MovieDataSource.Section
    
    var viewModel = MoviesViewModel(movieNetworkManager: MovieLocalNetworkManager())

    override func setUp() {
        super.setUp()
        
        let expectation = expectation(description: "Movies")
        viewModel.fetchMovies
        {
                expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testNumberOfSections() {
        let numberOfSections = viewModel.numberOfSections()
        XCTAssertEqual(numberOfSections, 5)
    }

    func testNumberOfRowsInSection() {
        let numberOfRowsInSection = viewModel.numberOfRowsInSection(section: 0)
        XCTAssertEqual(numberOfRowsInSection, .zero)
    }

    func testTitleForHeaderInSection() {
        let title = viewModel.titleForHeaderInSection(section: 2)
        XCTAssertEqual(title.lowercased(), "director")
    }

    func testIdentifierForRow() {
        let indexPath = IndexPath(row: 9, section: 0)
        viewModel.filterMovies(section: .zero)
        let identifier = (viewModel.getDataForRow(for: .actors, at: indexPath) as? GroupedMovies)?.identifier
        XCTAssertEqual(identifier, "Ben Stiller")
    }

    func testMoviesForRow() {
        let indexPath = IndexPath(row: 0, section: 3)
        viewModel.filterMovies(section: 3)
        let movies = (viewModel.getDataForRow(for: .director, at: indexPath) as? GroupedMovies)?.movies
        XCTAssertEqual(movies?.count, 4)
    }

    func testMovieDetailForRow() {
        let indexPath = IndexPath(row: 2, section: 0)
        viewModel.filterMovies(section: .zero)
        let releasedDate = viewModel.movieDetailForRow(at: indexPath).movies.first?.released
        
        XCTAssertEqual(releasedDate, "08 Jan 2000")
    }

    func testToggleSection() {
        viewModel.currentlyExpandedSection = 0
        viewModel.toggleSection(sectionIndex: 0)
        XCTAssertEqual(viewModel.currentlyExpandedSection, nil)

        viewModel.toggleSection(sectionIndex: 1)
        XCTAssertEqual(viewModel.currentlyExpandedSection, 1)

        viewModel.toggleSection(sectionIndex: 1)
        XCTAssertEqual(viewModel.currentlyExpandedSection, nil)
    }

    func testFilterMovies() {
        viewModel.searchBarText = "Adam"
        let indexPath = IndexPath(row: 0, section: 3)
        viewModel.filterMovies(section: .zero)
        let groupedMovie = viewModel.getDataForRow(for: .actors, at: indexPath) as? GroupedMovies
        XCTAssertEqual(groupedMovie?.movies.count, 2)
    }
}
