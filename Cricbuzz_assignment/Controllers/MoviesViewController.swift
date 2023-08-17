//
//  MoviesViewController.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 11/08/23.
//

import UIKit

class MoviesViewController: UIViewController
{
    enum Constants
    {
        static let title = "Movie Database"
        static let movieListSuffix = " Movies"
        static let titleCell = "MovieTitleCell"
        static let movieCell = "MovieCell"
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // instantiate local network manager
    private var viewModel: MoviesViewModel = .init(movieNetworkManager: MovieLocalNetworkManager())

    override func viewDidLoad()
    {
        super.viewDidLoad()

        title = Constants.title

        registerTableViewCells()
        fetchMovies()
    }

    private func registerTableViewCells()
    {
        tableView.register(MovieTitleTableViewCell.self, forCellReuseIdentifier: Constants.titleCell)
        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: Constants.movieCell)
        tableView.register(CollapsibleTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: CollapsibleTableViewHeaderView.reuseIdentifier)
    }

    private func fetchMovies()
    {
        viewModel.fetchMovies
        {
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }
    }
    
    private func filterMovies()
    {
        viewModel.filterMovies()
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let sectionType = viewModel.getSectionType(for: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionType.cellIdentifier, for: indexPath)
        
        let data = viewModel.getDataForRow(for: sectionType, at: indexPath)

        if let movie = data as? Movie, let cell = cell as? MovieDetailTableViewCell
        {
            cell.configure(with: movie)
        }
        else if let title = (data as? GroupedMovies)?.identifier, let cell = cell as? MovieTitleTableViewCell {
            cell.configure(with: title)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CollapsibleTableViewHeaderView.reuseIdentifier) as? CollapsibleTableViewHeaderView
        else { return nil }
        
        headerView.delegate = self
        headerView.section = section
        headerView.isCollapsed = viewModel.isSectionCollapsed(section: section)
        headerView.setTitle(title: viewModel.titleForHeaderInSection(section: section), hideIndicatorView: !viewModel.isSearchTextEmpty)
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionType = viewModel.getSectionType(for: indexPath.section)
        if sectionType == .allMovies,
           let movie = viewModel.getDataForRow(for: sectionType, at: indexPath) as? Movie
        {
            
            let movieDetailsVM = MovieDetailsViewModel(selectedMovie: movie)
            let movieDetailVC = MovieDetailViewController(viewModel: movieDetailsVM)
            navigationController?.pushViewController(movieDetailVC, animated: true)
        }
        else if let groupedMovie = viewModel.getDataForRow(for: sectionType, at: indexPath) as? GroupedMovies
        {
            let identifier = groupedMovie.identifier
            let movieListViewController = MovieListViewController(viewModel: .init(movies: groupedMovie.movies))
            movieListViewController.title = identifier + Constants.movieListSuffix
            navigationController?.pushViewController(movieListViewController, animated: true)
        }
    }
}

extension MoviesViewController: CollapsibleTableViewHeaderViewDelegate
{
    func toggleSection(headerView: CollapsibleTableViewHeaderView, section: Int)
    {
        guard viewModel.isSearchTextEmpty
        else { return }
        
        viewModel.toggleSection(sectionIndex: section)
        filterMovies()
    }
}


extension MoviesViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        viewModel.searchBarText = searchText
        filterMovies()
    }
}

