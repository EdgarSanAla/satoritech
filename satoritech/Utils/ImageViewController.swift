//
//  Untitled.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

class ImageViewController: UIImageView {
    
    let imageCache = CacheManager()
    
    func loadImage(from url: URL) {
        // Verificamos si la imagen está en caché
        if let cachedImage = imageCache.getImagen(forKey: url.absoluteString) {
            self.image = cachedImage
        } else {
            // Si no está en caché, la descargamos
            downloadImage(from: url) { image in
                if let image = image {
                    // Guardamos la imagen en caché
                    self.imageCache.guardarImagen(image: image, forKey: url.absoluteString)
                    // Actualizamos la imagenView
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
