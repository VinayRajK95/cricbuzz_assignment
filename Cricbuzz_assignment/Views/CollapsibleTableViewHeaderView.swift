//
//  CollapsibleTableViewHeaderView.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 17/08/23.
//

import UIKit

protocol CollapsibleTableViewHeaderViewDelegate: AnyObject
{
    func toggleSection(headerView: CollapsibleTableViewHeaderView, section: Int)
}

class CollapsibleTableViewHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "CollapsibleTableViewHeaderView"

    weak var delegate: CollapsibleTableViewHeaderViewDelegate?
    var section: Int = .zero

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var isCollapsed: Bool = true
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)

        // setup constraints
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func viewTapped() {
        delegate?.toggleSection(headerView: self, section: section)
    }
    
    func setTitle(title: String)
    {
        titleLabel.text = title
    }
}
