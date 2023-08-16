//
//  File.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 16/08/23.
//

//import Foundation
//class MoviesViewController: UIViewController
//{
//    enum Constants
//    {
//        static let title = "Movies"
//        static let titleCell = "MovieTitleCell"
//        static let movieCell = "MovieCell"
//    }
//
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
//
//    // instantiate local network manager
//    private var viewModel: MoviesViewModel = .init(movieNetworkManager: MovieLocalNetworkManager())
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        title = Constants.title
//
//        registerTableViewCells()
//        fetchMovies()
//    }
//
//    private func registerTableViewCells()
//    {
//        tableView.register(MovieTitleTableViewCell.self, forCellReuseIdentifier: Constants.titleCell)
//        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: Constants.movieCell)
//    }
//
//    private func fetchMovies()
//    {
//        viewModel.fetchMovies {
//            DispatchQueue.main.async
//            {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//}
//
//extension MoviesViewController: UITableViewDelegate, UITableViewDataSource
//{
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return isSearchTextEmpty ? viewModel.numberOfSections() : 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return viewModel.numberOfRowsInSection(section: section)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        guard let sectionType = viewModel.getSectionType(for: indexPath.section)
//        else { return .init() }
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: sectionType.cellIdentifier, for: indexPath)
//
////        if let titleCell = cell as? MovieTitleTableViewCell
////        {
////            titleCell.setupTitle(text: viewModel.identifierForRow(at: indexPath))
////        }
////        else if let movieCell = cell as? MovieDetailTableViewCell
////        {
////            movieCell.configure(with: viewModel.moviesForRow(at: .init(row: .zero, section: .zero))[indexPath.row])
////        }
//
//        if let configurableCell = cell as? (any ConfigurableCell)
//        {
//            let data = viewModel.getDataForRow(at: indexPath)
//            configurableCell.configure(with: data)
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        if isSearchTextEmpty
//        {
//                let headerView = UITableViewHeaderFooterView()
//                headerView.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
//                headerView.textLabel?.text = viewModel.titleForHeaderInSection(section: section)
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
//                headerView.tag = section
//                headerView.addGestureRecognizer(tapGestureRecognizer)
//                return headerView
//            }
//        else
//        {
//                return nil // Don't show headers when there's text in the search bar
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        tableView.deselectRow(at: indexPath, animated: true)
//
////        if viewModel.isAllMoviesSection(section: indexPath.section)
////        {
////            let movie = viewModel.moviesForRow(at: .init(row: .zero, section: .zero))[indexPath.row]
////            let movieDetailsVM = MovieDetailsViewModel(selectedMovie: movie)
////            let movieDetailVC = MovieDetailViewController(viewModel: movieDetailsVM)
////            navigationController?.pushViewController(movieDetailVC, animated: true)
////        }
////        else
////        {
////            let movies = viewModel.moviesForRow(at: indexPath)
////            let identifier = viewModel.identifierForRow(at: indexPath).components(separatedBy: ",").first ?? ""
////            let movieListViewController = MovieListViewController(viewModel: .init(movies: movies))
////            movieListViewController.title = identifier + " Movies"
////            navigationController?.pushViewController(movieListViewController, animated: true)
////        }
//    }
//
//    @objc func toggleSection(_ sender: UITapGestureRecognizer)
//    {
//        //        guard let section = sender.view?.tag,
//        //              let sectionType = MovieDataSource.Section(rawValue: section)
//        //        else { return }
//        //
//        //        viewModel.toggleSection(sectionIndex: section)
//        //        filterMovies(text: searchBar.text, section: sectionType)
//        guard let section = sender.view?.tag,
//              let sectionType = MovieDataSource.Section(rawValue: section),
//              isSearchTextEmpty
//        else { return }
//
//        filterMovies(section: sectionType)
//        viewModel.toggleSection(sectionIndex: section)
//    }
//
//    private func filterMovies(text: String? = nil, section: MovieDataSource.Section)
//    {
//        viewModel.filterMovies(text: text, section: section)
//        tableView.reloadData()
//    }
//
//}
//
//
//extension MoviesViewController: UISearchBarDelegate
//{
//    var isSearchTextEmpty: Bool
//    {
//        searchBar.text?.isEmpty ?? true
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
//    {
//        guard let section = viewModel.currentlyExpandedSection,
//              let sectionType = MovieDataSource.Section(rawValue: section)
//        else { return }
//
//        viewModel.filterMovies(text: searchText, section: sectionType)
//    }
//}
//
//protocol ConfigurableCell
//{
//    associatedtype DataType
//    func configure(with data: DataType)
//}
//
//class MovieTitleTableViewCell: UITableViewCell
//{
//    private let titleLabel: UILabel =
//    {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 14, weight: .light)
//        label.textAlignment = .left
//        label.numberOfLines = .zero
//        return label
//    }()
//
//    required init?(coder aDecoder: NSCoder)
//    {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
//    {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.addSubview(titleLabel)
//        titleLabel.fillInSuperView(leading: 32, trailing: 16, top: 8, bottom: 8)
//    }
//}
//
//extension MovieTitleTableViewCell: ConfigurableCell
//{
//    typealias DataType = String
//
//    func configure(with data: DataType)
//    {
//        titleLabel.text = data
//    }
//}
//class MovieDetailTableViewCell: UITableViewCell
//{
//    private let posterImageView: UIImageView =
//    {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private let titleLabel: UILabel =
//    {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.numberOfLines = .zero
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let actorsLabel: UILabel =
//    {
//        let label = UILabel()
//        label.textColor = .gray
//        label.numberOfLines = 2
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let runtimeLabel: UILabel =
//    {
//        let label = UILabel()
//        label.textColor = .gray
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let directorLabel: UILabel =
//    {
//        let label = UILabel()
//        label.textColor = .gray
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
//    {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        setupViews()
//        setupConstraints()
//    }
//
//    override func prepareForReuse()
//    {
//        super.prepareForReuse()
//        posterImageView.image = nil
//    }
//
//    required init?(coder aDecoder: NSCoder)
//    {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupViews()
//    {
//        contentView.addSubview(posterImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(actorsLabel)
//        contentView.addSubview(runtimeLabel)
//        contentView.addSubview(directorLabel)
//    }
//
//    private func setupConstraints()
//    {
//        // Constraints for posterImageView
//        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
//        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
//        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
//        posterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        // Constraints for titleLabel
//        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
//
//        // Constraints for actorsLabel
//        actorsLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
//        actorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
//        actorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
//
//        // Constraints for runtimeLabel
//        runtimeLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
//        runtimeLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 4).isActive = true
//
//        // Constraints for directorLabel
//        directorLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
//        directorLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 4).isActive = true
//        directorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12).isActive = true
//    }
//}
//
//extension MovieDetailTableViewCell: ConfigurableCell
//{
//    typealias DataType = Movie
//
//    func configure(with data: DataType)
//    {
//        let movie = data
//        titleLabel.text = movie.title
//        actorsLabel.text = "Actors: \(movie.actors)"
//        runtimeLabel.text = "Runtime: \(movie.runtime) mins"
//        directorLabel.text = "Director: \(movie.director)"
//
//        if let posterUrl = URL.init(string: movie.poster)
//        {
//            posterImageView.loadImage(from: posterUrl)
//        }
//    }
//}
//class MoviesViewModel
//{
//    typealias SectionType = MovieDataSource.Section
//    private var dataSource: MovieDataSource
//    private let kEmptyString = ""
//    var searchBarText: String
//
//    var currentlyExpandedSection: Int?
//
//    init(movieNetworkManager: NetworkManagerProtocol)
//    {
//        dataSource = MovieDataSource(networkManager: movieNetworkManager)
//        self.searchBarText = kEmptyString
//    }
//
//    func numberOfSections() -> Int
//    {
//        return dataSource.sectionData.count
//    }
//
//    func numberOfRowsInSection(section: Int) -> Int
//    {
//        if !searchBarText.isEmpty {
//            // Show the number of filtered rows when there's text in the search bar
//            return dataSource.filteredData.count
//        } else {
//            // Handle section expansion and collapse
//            if section == currentlyExpandedSection {
//                return dataSource.filteredData[section].movies.count
//            } else {
//                return 0
//            }
//        }
//    }
//
//    func isAllMoviesSection(section: Int) -> Bool
//    {
//        let allMoviesSection: Int = SectionType.allMovies.rawValue
//        return section == allMoviesSection
//    }
//
//    func titleForHeaderInSection(section: Int) -> String
//    {
//        return dataSource.sectionData[section].title
//    }
//
//    func getDataForRow(at indexPath: IndexPath) -> GroupedMovies
//    {
//        return dataSource.filteredData[indexPath.row]
//    }
//
//    func getSectionType(for section: Int) -> SectionType?
//    {
//        return SectionType.init(rawValue: section)
//    }
//
//    func movieDetailForRow(at indexPath: IndexPath) -> GroupedMovies
//    {
//        return dataSource.filteredData[indexPath.row]
//    }
//
//    func toggleSection(sectionIndex: Int)
//    {
//        if currentlyExpandedSection == sectionIndex
//        {
//            dataSource.sectionData[sectionIndex].isCollapsed = true
//            currentlyExpandedSection = nil
//        }
//        else
//        {
//            dataSource.sectionData[sectionIndex].isCollapsed = false
//            if let previousExpandedSection = currentlyExpandedSection
//            {
//                dataSource.sectionData[previousExpandedSection].isCollapsed = true
//            }
//            currentlyExpandedSection = sectionIndex
//        }
//    }
//
//    func filterMovies(text: String?, section: SectionType)
//    {
//        dataSource.filterMovies(text: text ?? kEmptyString, attribute: section)
//    }
//
//    func fetchMovies(comp: @escaping ()->Void)
//    {
//        dataSource.fetchMovies(comp: comp)
//    }
//}
//
////
////  MoviesModel.swift
////  Cricbuzz_assignment
////
////  Created by kiran raj on 11/08/23.
////
//
//import Foundation
//
//struct Movie: Codable
//{
//    let title, year, rated, released: String
//    let runtime, genre, director, writer: String
//    let actors, plot, language, country: String
//    let awards, poster: String
//    let ratings: [Rating]
//    let metascore, imdbRating, imdbVotes, imdbID: String
//    let boxOffice, production: String?
//
//    var actorsList: [String]
//    {
//        return parseList(from: actors)
//    }
//
//    var genreList: [String]
//    {
//        return parseList(from: genre)
//    }
//
//    var directorList: [String]
//    {
//        return parseList(from: director)
//    }
//
//    var yearList: [String]
//    {
//        return parseList(from: year, with: "-")
//    }
//
//    enum CodingKeys: String, CodingKey
//    {
//        case title = "Title"
//        case year = "Year"
//        case rated = "Rated"
//        case released = "Released"
//        case runtime = "Runtime"
//        case genre = "Genre"
//        case director = "Director"
//        case writer = "Writer"
//        case actors = "Actors"
//        case plot = "Plot"
//        case language = "Language"
//        case country = "Country"
//        case ratings = "Ratings"
//        case awards = "Awards"
//        case poster = "Poster"
//        case metascore = "Metascore"
//        case imdbRating, imdbVotes, imdbID
//        case boxOffice = "BoxOffice"
//        case production = "Production"
//    }
//
//    struct Rating: Codable {
//        let source: Source
//        let value: String
//
//        enum CodingKeys: String, CodingKey {
//            case source = "Source"
//            case value = "Value"
//        }
//
//        enum Source: String, Codable {
//            case internetMovieDatabase = "Internet Movie Database"
//            case metacritic = "Metacritic"
//            case rottenTomatoes = "Rotten Tomatoes"
//        }
//    }
//
//    private func parseList(from string: String,with separator: String = ",") -> [String]
//    {
//        return string.split(separator: separator).map { $0.trimmingCharacters(in: .whitespaces) }
//    }
//}
//
//struct GroupedMovies
//{
//    let identifier: String
//    let movies: [Movie]
//}
