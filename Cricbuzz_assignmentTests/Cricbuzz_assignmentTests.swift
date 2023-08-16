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
    
    var viewModel: MoviesViewModel!

    override func setUp() {
        super.setUp()
        
        let expectation = expectation(description: "Movies")
        JSONHelper.fetchMoviesModel { [unowned self] result in
            switch result {
                case .success(let movies):
                    viewModel = MoviesViewModel(movies: movies)
                    viewModel.filterMovies(text: "", section: .actors)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testNumberOfSections() {
        let numberOfSections = viewModel.numberOfSections()
        XCTAssertEqual(numberOfSections, 4)
    }

    func testNumberOfRowsInSection() {
        let numberOfRowsInSection = viewModel.numberOfRowsInSection(section: 0)
        XCTAssertEqual(numberOfRowsInSection, .zero)
    }

    func testTitleForHeaderInSection() {
        let title = viewModel.titleForHeaderInSection(section: 2)
        XCTAssertEqual(title, "director")
    }

    func testIdentifierForRow() {
        let indexPath = IndexPath(row: 9, section: 0)
        let identifier = viewModel.identifierForRow(at: indexPath)
        XCTAssertEqual(identifier, "James Rolfe")
    }

    func testMoviesForRow() {
        let indexPath = IndexPath(row: 0, section: 3)
        let movies = viewModel.moviesForRow(at: indexPath)
        XCTAssertEqual(movies.count, 1)
    }

    func testMovieDetailForRow() {
        let indexPath = IndexPath(row: 2, section: 0)
        let releasedDate = viewModel.movieDetailForRow(at: indexPath).movies.first?.released
        
        XCTAssertEqual(releasedDate, "27 Feb 2014")
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
        viewModel.filterMovies(text: "2005", section: .year)
        let indexPath = IndexPath(row: 0, section: 3)
        XCTAssertEqual(viewModel.moviesForRow(at: indexPath).count, 2)
    }
}
