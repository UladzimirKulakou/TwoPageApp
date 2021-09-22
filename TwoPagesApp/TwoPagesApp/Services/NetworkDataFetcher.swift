//
//  NetworkDataFetcher.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/19/21.
//

import Foundation

class NetworkDataFetcher {
    var networkService = NetworkService()
    
    // MARK: - создаем Data Fetcher
    
    func getImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(serchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error recived requesting data: \(error.localizedDescription)")
            }
            let decode = self.decodeJSON(type: SearchResults.self, frome: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, frome: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = frome else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Faild to decode JSON", jsonError)
            return nil
            
        }
    }
}
