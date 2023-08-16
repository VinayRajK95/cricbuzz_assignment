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
        let longPressGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UITapGestureRecognizer)
    {
        if gestureRecognizer.state == .began
        {
            showPopup()
        }
        else if gestureRecognizer.state == .ended
        {
            dismissPopup()
        }
    }
    
    private func showPopup()
    {
        NotificationCenter.default.post(name: NSNotification.Name("showPopup"), object: nil)
    }
    
    private func dismissPopup()
    {
        NotificationCenter.default.post(name: NSNotification.Name("dismissPopup"), object: nil)
    }
}
