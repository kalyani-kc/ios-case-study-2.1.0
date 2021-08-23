//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo
import SDWebImage

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        view.backgroundColor = UIColor.targetStarkWhiteColor
        view.layer.borderWidth = 1
        
        SDWebImageManager.shared.loadImage(with: item.image,
                                           options: .waitStoreCache,
                                           progress: nil,
                                           completed: { (image,_,_,_,_,_)  in
                                            view.productImage.image = image
                                           })
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(item: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
         180.0
    }
}
