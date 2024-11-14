//
//  ViewController.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

class GaleriaViewController: UIViewController, GaleriaViewProtocol {
    func displayResults(_ result: GaleriaEntity) {
        if let fotografias = result.fotografias {
            self.fotografias = fotografias
            self.collectionView.reloadData()
        }
        paginasTotales = result.paginasTotales ?? 1
    }
    
    func showLoadingIndicator() {
        loaderView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        loaderView.isHidden = true
    }
    
    func showError(_ mensaje: String) {
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var query: String?
    var paginaActual = 1
    var paginasTotales = 1
    var fotografias = [FotografiaEntity]()
    var presenter: GaleriaPresenterProtocol?
    
    let searchBar = UISearchBar()
    var collectionView: UICollectionView!
    var loaderView: UIView!
    var activityIndicator: UIActivityIndicatorView!
    let pageLabel = UILabel()
    let prevButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModulo()
        
        // Configurar la vista
        view.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
        setupPaginador()
        setupLoader()
    }
    func setupModulo() {
            let router = GaleriaRouter()
            let view = self
            let presenter = GaleriaPresenter()
            let interactor = GaleriaInteractor()

            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
        }
    
    // MARK: - Configuración del Search Bar
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Buscar en unsplash..."
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.delegate = self
        
        // Crear un botón para la búsqueda
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("Buscar", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        let searchBarStack = UIStackView(arrangedSubviews: [searchBar, searchButton])
        searchBarStack.axis = .horizontal
        searchBarStack.spacing = 8
        searchBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBarStack)
        
        // Asegurarse de que el search bar y el botón estén colocados adecuadamente
        NSLayoutConstraint.activate([
            searchBarStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBarStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupCollectionView() {
        
        // Crear el layout para el UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 140)  // La celda ocupará todo el ancho de la pantalla
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        // Crear el UICollectionView con el layout
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // Configuración del collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        // Registrar la celda personalizada
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    func setupPaginador() {
        prevButton.setTitle("<", for: .normal)
        nextButton.setTitle(">", for: .normal)
        
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        pageLabel.text = "Página \(paginaActual)"
        pageLabel.textAlignment = .center
        
        let paginationStack = UIStackView(arrangedSubviews: [prevButton, pageLabel, nextButton])
        paginationStack.axis = .horizontal
        paginationStack.spacing = 4
        paginationStack.distribution = .fillEqually
        paginationStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(paginationStack)
        
        NSLayoutConstraint.activate([
            paginationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paginationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paginationStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    func setupLoader() {
        loaderView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        loaderView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loaderView.layer.cornerRadius = 10
        loaderView.center = self.view.center
        loaderView.isHidden = true
        
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = CGPoint(x: loaderView.bounds.size.width / 2, y: loaderView.bounds.size.height / 2)
        
        loaderView.addSubview(activityIndicator)
        self.view.addSubview(loaderView)
    }
    
    func resetValores() {
        CacheManager.shared.removeAll()
        fotografias.removeAll()
        paginaActual = 1
        paginasTotales = 1
        pageLabel.text = "Página \(paginaActual)"
        collectionView.reloadData()
    }
    
    // MARK: - Acciones de los Botones
    @objc func searchButtonTapped() {
        if let query = searchBar.text, !query.isEmpty {
            resetValores()
            self.query = query
            presenter?.buscarResultados(query: query, page: paginaActual)
        }
    }
    
    @objc func prevButtonTapped() {
        if paginaActual > 1 {
            paginaActual -= 1
            updatePage()
        }
    }
    
    @objc func nextButtonTapped() {
        if paginasTotales > paginaActual {
            paginaActual += 1
            updatePage()
        }
    }
    
    func updatePage() {
        if let query{
            pageLabel.text = "Página \(paginaActual)"
            presenter?.buscarResultados(query: query, page: paginaActual)
        }
    }
    
}

// MARK: - CollectionView
extension GaleriaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotografias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = fotografias[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        cell.configureCell(with: item)
        return cell
    }
    
}

extension GaleriaViewController: UISearchBarDelegate, UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resetValores()
        return true
    }
}
