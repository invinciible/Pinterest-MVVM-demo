//
//  ViewController.swift
//  Pinterest-demo
//
//  Created by Tushar  on 14/03/18.
//  Copyright © 2018 Tushar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:  Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    // MARK:  Properties
   // let images = [#imageLiteral(resourceName: "image-1"),#imageLiteral(resourceName: "image-2"),#imageLiteral(resourceName: "image-3"),#imageLiteral(resourceName: "image-4"),#imageLiteral(resourceName: "image-5"),#imageLiteral(resourceName: "image-6"),#imageLiteral(resourceName: "image-7")]
    
    let viewModel = ViewModel(client: UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // init View model
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        viewModel.showError = { error in
            print(error)
        }
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        
        viewModel.fetchPhotos()
    }


}

// MARK:  Flow-Layout Delegate

extension ViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
     
       /*
        let image = viewModel.cellViewModels[indexPath.row].image
        return image.size.height */
        
        // for big height images
        let image = viewModel.cellViewModels[indexPath.row].image
        let modifiedImageHeight = image.size.height
        if modifiedImageHeight > self.view.frame.height / 2 {
            return self.view.frame.height / 2
        }
        return modifiedImageHeight / 1.5
        
        
    }
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfColumns : CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets :CGFloat = 10
        let cellSpacing : CGFloat = 5
        
        let image = images[indexPath.row]
        let height = image.size.height / 2
        
        return CGSize(width: (width / noOfColumns) - xInsets - cellSpacing, height: height)
    }
    */
    
    
}


// MARK:  Data Source
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        cell.pImageView.image = viewModel.cellViewModels[indexPath.row].image
        return cell
    }
    
}
