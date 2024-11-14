//
//  Extensiones.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

extension UIImage{
    func resizeImage(targetSize: CGSize) -> UIImage {
        // Crea un nuevo contexto de gráficos con el tamaño de destino
        UIGraphicsBeginImageContextWithOptions(targetSize, false, self.scale)
        
        // Dibuja la imagen en el contexto con el nuevo tamaño
        self.draw(in: CGRect(origin: .zero, size: targetSize))
        
        // Obtén la nueva imagen redimensionada
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Finaliza el contexto de gráficos
        UIGraphicsEndImageContext()
        
        return resizedImage ?? self
    }
}
