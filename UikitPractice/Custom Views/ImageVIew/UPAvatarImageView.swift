//
//  UPAvatarImageView.swift
//  UikitPractice
//
//  Created by Shashank Gautam on 23/10/26.
//

import UIKit

class UPAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(systemName: "photo")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(for urlString : String){
        let cachedKey = NSString(string: urlString)
        let image = cache.object(forKey: cachedKey)
        if let image = image {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else  { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response,_ in
            guard let self = self else { return }
            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else { return }
            
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cachedKey)
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        task.resume()
    }
    
}
