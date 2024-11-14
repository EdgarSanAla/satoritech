//
//  CacheManager.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import Foundation
import UIKit

class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, AnyObject>()
    
    
    func cacheObject(forKey key: String, object: AnyObject) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getObject(forKey key: String) -> AnyObject? {
        return cache.object(forKey: key as NSString)
    }
    
    func removeAll() {
        cache.removeAllObjects()
    }
    
    func guardarImagen(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImagen(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString) as? UIImage
    }
    
    func borrarImagen(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
