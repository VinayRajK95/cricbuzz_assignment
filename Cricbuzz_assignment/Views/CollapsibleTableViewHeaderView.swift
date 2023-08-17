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

class CollapsibleTableViewHeaderView: UITableViewHeaderFooterView
{
    static let reuseIdentifier = "CollapsibleTableViewHeaderView"
    
    weak var delegate: CollapsibleTableViewHeaderViewDelegate?
    var section: Int = .zero
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let indicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var isCollapsed: Bool = true
    {
        didSet
        {
            indicatorLabel.text = isCollapsed ? "+" : "–"
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicatorLabel)
        
        // setup constraints
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIUtils.twentyFourPX).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIUtils.eightPX).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIUtils.eightPX).isActive = true
        
        indicatorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: UIUtils.twelvePX).isActive = true
        indicatorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIUtils.twentyFourPX).isActive = true
        indicatorLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func viewTapped()
    {
        isCollapsed.toggle()
        delegate?.toggleSection(headerView: self, section: section)
    }
    
    func setTitle(title: String, hideIndicatorView: Bool = false)
    {
        titleLabel.text = title
        indicatorLabel.isHidden = hideIndicatorView
    }
}
