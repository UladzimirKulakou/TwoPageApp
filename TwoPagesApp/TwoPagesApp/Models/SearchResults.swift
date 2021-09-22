//
//  SearchResults.swift
//  TwoPagesApp
//
//  Created by Uladzimir Kulakou on 9/19/21.
//

import Foundation

// MARK: - создаем модель данных которые будем получать от unsplash  в виде JSON посмотреть ответ можно на сайте (вид отличается в зависимости от запроса)

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue : String]

    }
enum URLKing: String {
    case raw
    case full
    case regular
    case small
    case thumb
}
