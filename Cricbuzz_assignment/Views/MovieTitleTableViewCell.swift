//
//  MovieTableViewCell.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

protocol ConfigurableCell
{
    associatedtype DataType
    func configure(with data: DataType)
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
    func configure(with data: String)
    {
        titleLabel.text = data
    }
}
