//
//  MovieListViewController.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

class MovieListViewController: UIViewController
{
    private let cellReuserIdentifier = "Cell"
    private lazy var tableView: UITableView =
    {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
    }
    
    private func setupTableView()
    {
        view.addSubview(tableView)
        tableView.fillInSuperView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuserIdentifier)
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuserIdentifier, for: indexPath)
        let movie = viewModel.movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieDetailsVM = MovieDetailsViewModel(selectedMovie: viewModel.movies[indexPath.row])
        let movieDetailVC = MovieDetailViewController(viewModel: movieDetailsVM)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
