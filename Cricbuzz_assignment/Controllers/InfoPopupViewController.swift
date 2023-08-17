//
//  InfoPopupViewController.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

class InfoPopupViewController: UIViewController
{
    private var stackView: UIStackView!
    
    private let imbdRating: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rottenTomatosLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let metacriticLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(imdbRating: String?, rTRating: String?, mCRating: String?)
    {
        super.init(nibName: nil, bundle: nil)
        
        imbdRating.text = imdbRating
        rottenTomatosLabel.text = rTRating
        metacriticLabel.text = mCRating
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
        preferredContentSize = .init(width: 230, height: 40)
    }

    private func setupUI()
    {
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [imbdRating, rottenTomatosLabel, metacriticLabel])
        stackView.setContentHuggingPriority(.required, for: .vertical)
        stackView.axis = .vertical
        stackView.spacing = UIUtils.eightPX
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIUtils.eightPX),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIUtils.eightPX),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIUtils.eightPX),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -UIUtils.eightPX)
        ])
    }
}
