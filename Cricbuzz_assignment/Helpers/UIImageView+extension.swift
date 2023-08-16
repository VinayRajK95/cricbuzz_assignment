//
//  UIImageView+extension.swift
//  Cricbuzz_assignment
//
//  Created by kiran raj on 12/08/23.
//

import UIKit

extension UIImageView
{
    private static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from url: URL, placeholder: UIImage? = nil)
    {
        self.image = placeholder
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        else
        {
            DispatchQueue.global().async {
                var poster = UIImage.init(named: "Poster_not_available")
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data)
                {
                    UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    poster = image
                }
                DispatchQueue.main.async {
                    self.image = poster
                }
            }
        }
    }
}
