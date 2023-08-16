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
        static let title = "Movies"
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
    }

    private func fetchMovies()
    {
        viewModel.fetchMovies {
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }
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
        guard let sectionType = viewModel.getSectionType(for: indexPath.section)
        else { return .init() }

        let cell = tableView.dequeueReusableCell(withIdentifier: sectionType.cellIdentifier, for: indexPath)
        
        let data = viewModel.getDataForRow(for: sectionType, at: indexPath)

        if sectionType == .allMovies, let movie = data as? Movie, let cell = cell as? MovieDetailTableViewCell {
            cell.configure(with: movie)
        } else if let title = data as? String, let cell = cell as? MovieTitleTableViewCell {
            cell.configure(with: title)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        headerView.textLabel?.text = viewModel.isSearchTextEmpty ? viewModel.titleForHeaderInSection(section: section) : "Filtered movies"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        headerView.tag = section
        headerView.addGestureRecognizer(tapGestureRecognizer)
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if viewModel.isAllMoviesSection(section: indexPath.section)
//        {
//            let movie = viewModel.moviesForRow(at: .init(row: .zero, section: .zero))[indexPath.row]
//            let movieDetailsVM = MovieDetailsViewModel(selectedMovie: movie)
//            let movieDetailVC = MovieDetailViewController(viewModel: movieDetailsVM)
//            navigationController?.pushViewController(movieDetailVC, animated: true)
//        }
//        else
//        {
//            let movies = viewModel.moviesForRow(at: indexPath)
//            let identifier = viewModel.identifierForRow(at: indexPath).components(separatedBy: ",").first ?? ""
//            let movieListViewController = MovieListViewController(viewModel: .init(movies: movies))
//            movieListViewController.title = identifier + " Movies"
//            navigationController?.pushViewController(movieListViewController, animated: true)
//        }
    }

    @objc func toggleSection(_ sender: UITapGestureRecognizer)
    {
        guard let section = sender.view?.tag,
              let sectionType = MovieDataSource.Section(rawValue: section),
              viewModel.isSearchTextEmpty
        else { return }
        
        viewModel.toggleSection(sectionIndex: section)
        filterMovies(section: sectionType)
    }

    private func filterMovies(section: MovieDataSource.Section)
    {
        viewModel.filterMovies(section: section)
        tableView.reloadData()
    }

}


extension MoviesViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        viewModel.searchBarText = searchText
        filterMovies(section: .allMovies)
    }
}

