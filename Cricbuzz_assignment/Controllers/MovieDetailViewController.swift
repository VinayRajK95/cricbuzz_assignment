//
//  MovieDetailViewController.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

class MovieDetailViewController: UIViewController
{
    private var viewModel: MovieDetailsViewModel
    
    private let posterImageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plotLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actors: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingInfo: RatingControl =
    {
        let control = RatingControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    init(viewModel: MovieDetailsViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupUI()
        setData()
        addNotifications()
    }
    
    private func addNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name("showPopup"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPopup), name: NSNotification.Name("dismissPopup"), object: nil)
    }
    
    private func setupUI()
    {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actors)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(ratingInfo)
        contentView.addSubview(plotLabel)
        
        NSLayoutConstraint.activate([
            // posterImageView constraints
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 300),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),

            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            // actors constraints
            actors.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            actors.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            actors.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            // releaseDateLabel constraints
            releaseDateLabel.topAnchor.constraint(equalTo: actors.bottomAnchor, constant: 12),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            // genreLabel constraints
            genreLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 12),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            // ratingLabel constraints
            ratingLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            // ratingInfo constraints
            ratingInfo.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8),
            ratingInfo.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            ratingInfo.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            ratingInfo.widthAnchor.constraint(equalToConstant: 24),
            ratingInfo.heightAnchor.constraint(equalToConstant: 24),

            // plotLabel constraints
            plotLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 12),
            plotLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            plotLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            plotLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func setData()
    {
        let movie = viewModel.selectedMovie
        titleLabel.text = movie.title
        plotLabel.text = "Plot: \(movie.plot)"
        actors.text = "Actors: \(movie.actors)"
        releaseDateLabel.text = "Release Date: \(movie.released)"
        genreLabel.text = "Genre: \(movie.genre)"
        ratingLabel.text = "imbd Rating: \(movie.imdbRating)"
        
        if let posterUrl = URL.init(string: movie.poster)
        {
            posterImageView.loadImage(from: posterUrl)
        }
    }
    
    private func getFormatedRating() -> (String?,String?,String?)
    {
        let rating = viewModel.selectedMovie.ratings
        
        var formattedRating: [String] = []
        for item in rating {
            let source = item.source, value = item.value
            let formattedString = "\(source): \(value)"
            formattedRating.append(formattedString)
        }
        
        var imdbRating: String?
        var rTRating: String?
        var mCRating: String?

        if formattedRating.indices.contains(0) {
            imdbRating = formattedRating[0]
        }
        if formattedRating.indices.contains(1) {
            rTRating = formattedRating[1]
        }
        if formattedRating.indices.contains(2) {
            mCRating = formattedRating[2]
        }
        return (imdbRating,rTRating,mCRating)
    }

}

extension MovieDetailViewController: UIPopoverPresentationControllerDelegate
{
    @objc private func showPopUp()
    {
        let ratings = getFormatedRating()

        let popoverContentViewController = InfoPopupViewController(imdbRating: ratings.0, rTRating: ratings.1, mCRating: ratings.2)
        
        let nav = UINavigationController(rootViewController: popoverContentViewController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover

        if let popoverController = nav.popoverPresentationController
        {
            popoverController.delegate = self
            popoverController.sourceView = ratingInfo
            popoverController.permittedArrowDirections = [.down, .up]
            popoverController.sourceRect = ratingInfo.bounds
        }

        present(nav, animated: true, completion: nil)
    }
    
    @objc private func dismissPopup()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

