//
//  CustomCollectionViewCell.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var presenter: GaleriaPresenterProtocol?
    
    var imageViewCell: ImageViewController!
    var descriptionLabel: UILabel!
    var authorLabel: UILabel!
    var stackView: UIStackView!
    var textStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Inicialización de las vistas
        imageViewCell = ImageViewController()
        descriptionLabel = UILabel()
        authorLabel = UILabel()
        
        // Configurar la imagen
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.contentMode = .scaleAspectFill
        imageViewCell.clipsToBounds = true
        let placeHolder = UIImage(systemName: "photo")
        imageViewCell.image = placeHolder?.resizeImage(targetSize: CGSize(width: 120, height: 120))
        imageViewCell.tintColor = .lightGray
        
        // Configurar la descripción
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Configurar el autor
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textColor = .black
        
        // Crear StackView vertical para los textos
        textStackView = UIStackView(arrangedSubviews: [descriptionLabel, authorLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .leading
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // StackView horizontal que contiene la imagen y los textos
        stackView = UIStackView(arrangedSubviews: [imageViewCell, textStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        // Agregar las restricciones
        NSLayoutConstraint.activate([
            // Configuración del StackView
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Configuración de la imagen
            imageViewCell.widthAnchor.constraint(equalToConstant: 120),  // Ancho fijo para la imagen
            imageViewCell.heightAnchor.constraint(equalToConstant: 120), // Alto fijo para la imagen
            
            // Configuración de la StackView vertical para el texto
            textStackView.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 10),
            textStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            textStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            textStackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with fotografia: FotografiaEntity) {
        if let urlString = fotografia.links["download"], let url = URL(string: urlString) {
            imageViewCell.loadImage(from: url)
        }
        descriptionLabel.text = fotografia.description
        authorLabel.text = fotografia.user.name
    }
}
