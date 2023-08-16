//
//  UIView+constraints.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

extension UIView
{
    func fillInSuperView(leading: CGFloat = .zero, trailing: CGFloat = .zero,
                         top: CGFloat = .zero, bottom: CGFloat = .zero)
    {
        guard let superview
        else {
            debugPrint("Error superview not found")
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom)])
    }
}
