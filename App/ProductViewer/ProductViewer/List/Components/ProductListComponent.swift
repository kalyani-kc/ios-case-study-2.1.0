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
    
    fileprivate func configureAisleLabel(_ view: ProductListView) {
        view.aisleLabel.text = "B2"
        view.aisleLabel.textColor = .targetRonBurgundyColor
        view.aisleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.aisleLabel.layer.cornerRadius = view.aisleLabel.bounds.size.width/2
        view.aisleLabel.layer.borderWidth = 1.0
        view.aisleLabel.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
    }
    
    fileprivate func configureAtrributedText(_ view: ProductListView) {
        let greyColorAttribute = [NSAttributedString.Key.foregroundColor : UIColor.targetStrokeGrayColor]
        let mutableStrOr = NSMutableAttributedString(string: " or",
                                                     attributes: greyColorAttribute)
        let charcoalColorAttribute = [NSAttributedString.Key.foregroundColor : UIColor.targetBlackFridayCharcoalColor]
        let mutableStrShip = NSMutableAttributedString(string: "ship",
                                                       attributes: charcoalColorAttribute)
        mutableStrShip.append(mutableStrOr)
        view.shipLabel.attributedText = mutableStrShip
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        view.backgroundColor = UIColor.targetStarkWhiteColor
        view.layer.borderWidth = 1
        
        configureAisleLabel(view)
        configureAtrributedText(view)
        
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
