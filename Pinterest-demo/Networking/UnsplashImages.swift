//
//  UnsplashImages.swift
//  Pinterest-demo
//
//  Created by Tushar  on 15/03/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

struct Photo : Codable {
    let id :String
    let urls :URlS
}

struct URlS : Codable {
    let raw : URL
    let full : URL
    let regular : URL
    let small : URL
    let thumb : URL
}
