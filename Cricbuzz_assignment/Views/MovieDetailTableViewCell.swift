//
//  MovieDetailTableViewCell.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell
{
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actorsLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let runtimeLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directorLabel: UILabel =
    {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actorsLabel)
        contentView.addSubview(runtimeLabel)
        contentView.addSubview(directorLabel)
    }
    
    private func setupConstraints()
    {
        // Constraints for posterImageView
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIUtils.twelvePX).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIUtils.twelvePX).isActive = true
        posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -UIUtils.twelvePX).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Constraints for titleLabel
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: UIUtils.twelvePX).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIUtils.twelvePX).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIUtils.twelvePX).isActive = true
        
        // Constraints for actorsLabel
        actorsLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: UIUtils.twelvePX).isActive = true
        actorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIUtils.twelvePX).isActive = true
        actorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIUtils.eightPX).isActive = true
        
        // Constraints for runtimeLabel
        runtimeLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: UIUtils.twelvePX).isActive = true
        runtimeLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: UIUtils.fourPX).isActive = true
        
        // Constraints for directorLabel
        directorLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: UIUtils.twelvePX).isActive = true
        directorLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: UIUtils.fourPX).isActive = true
        directorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -UIUtils.twelvePX).isActive = true
    }
}

extension MovieDetailTableViewCell: ConfigurableCell
{
    func configure(with data: Movie)
    {
        let movie = data
        titleLabel.text = movie.title
        actorsLabel.text = "Actors: \(movie.actors)"
        runtimeLabel.text = "Runtime: \(movie.runtime) mins"
        directorLabel.text = "Director: \(movie.director)"
        
        if let posterUrl = URL.init(string: movie.poster)
        {
            posterImageView.loadImage(from: posterUrl)
        }
    }
}
