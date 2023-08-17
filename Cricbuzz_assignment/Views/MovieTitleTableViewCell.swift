//
//  MovieTableViewCell.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

/*
 not using associated type bcuz we would have to downcast the type to know what kind of cell is to be used(was asked to call cell.configure only once)
 probable code in cellForRow(at)
 if let movie = data as? Movie, let cell = cell as? MovieDetailTableViewCell
 {
     cell.configure(with: movie)
 }
 else if let title = (data as? GroupedMovies)?.identifier, let cell = cell as? MovieTitleTableViewCell {
     cell.configure(with: title)
 }
 */

protocol ConfigurableCell
{
//    associatedtype DataType
    func configure(with data: Any)
}

class MovieTitleTableViewCell: UITableViewCell
{
    private let titleLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.fillInSuperView(leading: UIUtils.thirtTwoPX, trailing: UIUtils.twelvePX, top: UIUtils.eightPX, bottom: UIUtils.eightPX)
    }
}

extension MovieTitleTableViewCell: ConfigurableCell
{
    func configure(with data: Any)
    {
        titleLabel.text = (data as? GroupedMovies)?.identifier
    }
}
