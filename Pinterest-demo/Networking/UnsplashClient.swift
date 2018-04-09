//
//  UnsplashClient.swift
//  Pinterest-demo
//
//  Created by Tushar  on 15/03/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import Foundation

class UnsplashClient : APIClient{
    
    static let baseUrl = "https://api.unsplash.com"
    static let apiKey = "582195f62c9d71b9db1ca8ca9f88cc124262586fc6254ca64e7b07dde0dc991d"
    
    func fetch(with endpoint:UnsplashEndpoint,completion : @escaping (Either<Photos>)->()) {
        
        let request = endpoint.request
        
        get(with: request, handler: completion)
    }
}
