//
//  RatingControl.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

protocol RatingControlDelegate
{
    func showPopUp()
    func dismiss()
}

class RatingControl: UIControl
{
    private let infoIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "info.circle"))
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupUI()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        addSubview(infoIcon)
        
        infoIcon.fillInSuperView()
    }
    
    private func setupGestureRecognizers()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handletap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handletap(_ gestureRecognizer: UITapGestureRecognizer)
    {
        showPopup()
    }
    
    private func showPopup()
    {
        NotificationCenter.default.post(name: NSNotification.Name("showPopup"), object: nil)
    }
    
    private func dismissPopup()
    {
        // Do nothing
        // Popover gets dismissed by itself
    }
}
