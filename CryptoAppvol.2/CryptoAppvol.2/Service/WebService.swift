//
//  WebService.swift
//  CryptoAppvol.2
//
//  Created by Wiktor Witkowski on 12/03/2024.
//

import Foundation

class WebService {
    
//    func downloadDataAsync(url : URL) async throws -> [Currency]{
//       
//       let (data, response) = try await URLSession.shared.data(from: url)
//        
//        let currencies = try? JSONDecoder().decode([Currency].self, from: data)
//        
//        return currencies ?? []
//        
//    }
    
    func downloadCurrenciesContinuation(url : URL) async throws -> [Currency] {
        
        try await withCheckedThrowingContinuation( { continuation in
            downloadData(url: url) { result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
    }
    
    
    
    
    func downloadData(url : URL, completion: @escaping (Result<[Currency]?,DownloaderError>) -> Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([Currency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
        }.resume()
        
    }
}
    
    enum DownloaderError  : Error {
        case badUrl
        case noData
        case dataParseError
    
    
}
