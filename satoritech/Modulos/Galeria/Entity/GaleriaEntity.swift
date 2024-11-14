//
//  GaleriaEntity.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

class GaleriaEntity: Codable {
    var fotografias: [FotografiaEntity]?
    var paginasTotales: Int?
    var fotografiasTotales: Int?
    
    init(fotografias: [FotografiaEntity]? = nil, paginasTotales: Int? = nil, fotografiasTotales: Int? = nil) {
        self.fotografias = fotografias
        self.paginasTotales = paginasTotales
        self.fotografiasTotales = fotografiasTotales
    }
}
