//
//  GaleriaRouter.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

class GaleriaRouter: GaleriaRouterProtocol {
    static func cargarModulo() -> UIViewController {
        let view = GaleriaViewController()
        let presenter = GaleriaPresenter()
        let interactor = GaleriaInteractor()
        let router = GaleriaRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
