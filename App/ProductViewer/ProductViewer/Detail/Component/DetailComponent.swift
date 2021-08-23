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
    
    fileprivate func configureSalePrice(_ salePrice: String, _ item: DetailItemViewState, _ view: DetailView) {
        let saleAttribute = [NSAttributedString.Key.foregroundColor : UIColor.targetBullseyeRedColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        let salePriceStr = NSMutableAttributedString(string: salePrice,
                                                     attributes: saleAttribute)
        let strikeAttribute = [NSAttributedString.Key.strikethroughColor : UIColor.targetBullseyeRedColor,
                               NSAttributedString.Key.strikethroughStyle:  NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let actualPriceStr = NSMutableAttributedString(string: item.price + " ",
                                                       attributes: strikeAttribute)
        actualPriceStr.append(NSMutableAttributedString(string: " Now "))
        actualPriceStr.append(salePriceStr)
        view.productPrice.attributedText = actualPriceStr
    }
    
    func configureView(_ view: DetailView, item: DetailItemViewState){
        view.descLabel.text = item.desc
        if let salePrice = item.salePrice {
            configureSalePrice(salePrice, item, view)
        } else {
            view.productPrice.text = item.price
        }
        view.backgroundColor = UIColor.targetStarkWhiteColor
        
        view.buttonAddToCart.setTitle("add to cart", for: .normal)
        view.buttonAddToCart.backgroundColor = .targetBullseyeRedColor
        view.buttonAddToCart.tintColor = .targetStarkWhiteColor
        view.buttonAddToCart.layer.cornerRadius = 4

        view.buttonAddToList.backgroundColor = .targetStrokeGrayColor
        view.buttonAddToList.setTitle("add to list", for: .normal)
        view.buttonAddToList.tintColor = .targetBlackFridayCharcoalColor
        view.buttonAddToList.layer.cornerRadius = 4
        
        SDWebImageManager.shared.loadImage(with: item.image,
                                           options: .waitStoreCache,
                                           progress: nil,
                                           completed: { (image,_,_,_,_,_)  in
                                            view.productImage.image = image
                                           })
    }
}
