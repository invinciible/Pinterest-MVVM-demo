//
//  EndPoint.swift
//  Pinterest-demo
//
//  Created by Tushar  on 15/03/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl : String { get }
    var path : String { get }
    var urlParameters : [URLQueryItem] { get }
}

extension Endpoint {
    
    var urlComonent : URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        return urlComponent!
    }
    var request : URLRequest {
        return URLRequest(url: urlComonent.url!)
    }
}


enum Order :String {
    case latest, popular, oldest
}

enum UnsplashEndpoint: Endpoint {
    case photos(id: String, order :Order)
    
    var baseUrl: String {
        return "https://api.unsplash.com"
    }
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }
    var urlParameters: [URLQueryItem] {
        switch self {
        case .photos(let id,let order):
            return [
                    URLQueryItem(name: "client_id", value: id),
                    URLQueryItem(name: "order_by", value: order.rawValue)
                ]
        }
    }
}
