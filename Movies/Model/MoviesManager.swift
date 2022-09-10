//
//  MoviesManager.swift
//  Movies
//
//  Created by Ali Demirtaş on 4.09.2022.
//

import Foundation

protocol MoviesManagerDelegate {
    func didUpdateMovies(movie : [Results])
    func didFailWithError(error: Error)
}

struct MoviesManager {
    
    var delegate: MoviesManagerDelegate?
    
    func fetchMovies(pageName: String)  {
        let urlString = "\(Api.mainUrl)\(pageName)\(Api.apiKey)"
        performReques(urlString: urlString)
    }
    
    func performReques(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    
                    return
                }
                if let safeData = data {
                    if let movie = self.parseJSON(safeData) {
                        delegate?.didUpdateMovies(movie: movie)
                        
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ moviesData: Data) -> [Results]? {
        
        var m = [Results]()
        
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
            m = decodedData.results
            return m
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

