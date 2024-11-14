//
//  GaleriaProtocols.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

protocol GaleriaViewProtocol: AnyObject {
    func displayResults(_ results: GaleriaEntity)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(_ message: String)
}

protocol GaleriaPresenterProtocol: AnyObject {
    func buscarResultados(query: String, page: Int)
}

protocol GaleriaInteractorProtocol: AnyObject {
    func fetchResultados(query: String, page: Int, completion: @escaping (Result<GaleriaEntity, Error>) -> Void)
}

protocol GaleriaRouterProtocol: AnyObject {
    static func cargarModulo() -> UIViewController
}
