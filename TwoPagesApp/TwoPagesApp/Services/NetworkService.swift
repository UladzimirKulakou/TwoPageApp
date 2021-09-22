//
//  NetworkService.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/19/21.
//

import Foundation

class NetworkService {
    
    // MARK: - запрос на сервер

    func request(serchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParam(searchTerm: serchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()

    }
    
    // MARK: - Header нашего запроса, здесь важен ключ авторизации - берем его с сервера unsplash после регистрации на нем нашего приложения

    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 6W1qFOppgdY7o5fJssjkSzFnlz1kWdYgwJlQnaaFB6w"
        return headers
    }
    
    // MARK: - параметры запроса

    private func prepareParam(searchTerm: String?) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["query"] = searchTerm
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(30)

        return parametrs
    }

    // MARK: - собираем url
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }

        }
    }
}
