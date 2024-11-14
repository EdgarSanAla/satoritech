//
//  GaleriaPresenter.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//
import Foundation

class GaleriaPresenter: GaleriaPresenterProtocol {
    var view: GaleriaViewProtocol?
    var interactor: GaleriaInteractorProtocol?
    var router: GaleriaRouterProtocol?

    func buscarResultados(query: String, page: Int) {
        view?.showLoadingIndicator()
        if let cachedObject = CacheManager.shared.getObject(forKey: String(page)) as? GaleriaEntity{
            self.view?.hideLoadingIndicator()
            self.view?.displayResults(cachedObject)
        }else{
            interactor?.fetchResultados(query: query, page: page) { [weak self] result in
                DispatchQueue.main.async {
                    self?.view?.hideLoadingIndicator()
                    switch result {
                    case .success(let results):
                        self?.view?.displayResults(results)
                    case .failure(let error):
                        self?.view?.showError(error.localizedDescription)
                    }
                }
            }
        }
    }
}
