//
//  GaleriaInteractor.swift
//  satoritech
//
//  Created by Edgar Sánchez on 13/11/24.
//

import Foundation

class GaleriaInteractor: GaleriaInteractorProtocol {
    
    var presenter: GaleriaPresenterProtocol?
    
    func fetchResultados(query: String, page: Int, completion: @escaping (Result<GaleriaEntity, Error>) -> Void) {
        var fotografias = [FotografiaEntity]()
        guard let accessKey = ProcessInfo.processInfo.environment["UNSPLASH_ACCESS_KEY"] else {
            completion(.failure(NSError(domain: "No se encontró la clave de acceso a la API de Unsplash", code: 0)))
            return
        }
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)") else {
            completion(.failure(NSError(domain: "URL inválida", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No se recibió datos de la respuesta.", code: 0)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonResponse = json as? [String: Any],
                   let results = jsonResponse["results"] as? [[String: Any]],
                   let paginasTotales = jsonResponse["total_pages"] as? Int,
                   let total = jsonResponse["total"] as? Int{
                    
                    if total == 0 {
                        completion(.failure(NSError(domain: "No se recibió datos de la respuesta.", code: 0)))
                        return
                    }
                    for result in results {
                        let resultData = try JSONSerialization.data(withJSONObject: result, options: [])
                        
                        let foto = try decoder.decode(FotografiaEntity.self, from: resultData)
                        
                        fotografias.append(foto)
                    }
                    let galeria = GaleriaEntity(fotografias: fotografias, paginasTotales: paginasTotales, fotografiasTotales: total)
                    CacheManager.shared.cacheObject(forKey: String(page), object: galeria)
                    completion(.success(galeria))
                } else {
                    completion(.failure(NSError(domain: "Formato JSON inválido", code: 1)))
                }
            } catch {
                print("Error al parsear la respuesta JSON: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
