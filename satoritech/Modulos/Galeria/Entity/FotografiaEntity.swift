//
//  FotografiaEntity.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import Foundation

class FotografiaEntity: Codable {
    let id: String
    let description: String?
    let links: [String: String]
    let updated_at: String?
    let user: UsuarioEntity
}
