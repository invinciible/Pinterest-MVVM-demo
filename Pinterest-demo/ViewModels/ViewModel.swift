//
//  ViewModel.swift
//  Pinterest-demo
//
//  Created by Tushar  on 15/03/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel {
    let image : UIImage
}

class ViewModel {
    
    // MARK:  Properties
    
    private let client : APIClient
    private var photos : Photos = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    var cellViewModels : [CellViewModel] = []
    
    
    // MARK:  UI
    
    var isLoading = false {
        didSet {
            showLoading?()
        }
    }
    
    var showLoading : (() -> Void)?
    var reloadData : (() -> Void)?
    var showError : ((Error) -> Void)?
    
    
    init(client: APIClient) {
        self.client = client
    }
    
    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true
            let endPoint = UnsplashEndpoint.photos(id: UnsplashClient.apiKey, order: .latest)
            client.fetch(with: endPoint ) { (either) in
                switch either {
                case .error(let error) : self.showError?(error)
                    
                case .success(let photos) : self.photos = photos
                }
            }
        }
    }
    
    private func fetchPhoto() {
        
        let group = DispatchGroup()
        
        self.photos.forEach { (photo) in
        
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf: photo.urls.small) else {
                    self.showError?(APIError.imageDownload)
                    return }
                guard let image = UIImage(data: imageData) else {
                    self.showError?(APIError.imageConvert)
                    return }
                self.cellViewModels.append(CellViewModel(image: image))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()
        }
    }
}










