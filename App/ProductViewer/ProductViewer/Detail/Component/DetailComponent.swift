//
//  DetailComponent.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 23/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import SDWebImage

struct DetailComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: DetailView, item: DetailItemViewState) {
        // Called on first view
    }
    
    func configureView(_ view: DetailView, item: DetailItemViewState){
        view.descLabel.text = item.desc
        view.productPrice.text = item.price
        view.backgroundColor = UIColor.targetStarkWhiteColor
        view.buttonAddToCart.setTitle("add to cart", for: .normal)
        view.buttonAddToList.setTitle("add to list", for: .normal)
        view.buttonAddToCart.backgroundColor = .targetBullseyeRedColor
        view.buttonAddToList.backgroundColor = .targetStrokeGrayColor
        view.buttonAddToCart.tintColor = .targetStarkWhiteColor
        view.buttonAddToList.tintColor = .targetBlackFridayCharcoalColor
        view.buttonAddToCart.layer.cornerRadius = 4
        view.buttonAddToList.layer.cornerRadius = 4
        
        SDWebImageManager.shared.loadImage(with: item.image,
                                           options: .waitStoreCache,
                                           progress: nil,
                                           completed: { (image,_,_,_,_,_)  in
                                            view.productImage.image = image
                                           })
    }
}
