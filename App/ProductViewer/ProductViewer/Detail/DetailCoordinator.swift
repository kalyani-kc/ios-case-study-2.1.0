//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import SDWebImage

/*
 Coordinator for the product detail
 */
class DetailCoordinator: TempoCoordinator {
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: DetailViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var detailViewController: DetailListViewController = {
        return DetailListViewController.viewControllerFor(coordinator: self)
    }()
    
    var serviceHelper: DealsDetailsServiceEntity?
    
    // MARK: Init
    
    required init(detailID: String) {
        viewState = DetailViewState(listItems: [])
        serviceHelper = DealsDetailsService()
        updateState(for: Int(detailID) ?? 0)
    }
    
    // MARK: ListCoordinator
    
    func updateState(for id: Int) {
        
        self.serviceHelper?.getDealDetails(for: id,
                                           completion: { [weak self] (product, message) in
                                            guard let detail = product else {
                                                //display error view
                                                return
                                            }
                                            self?.setupDetailsView(for: detail)
                                           })
    }
    
    func setupDetailsView(for product: Product) {
        DispatchQueue.main.async { [weak self] in
            if  let rootVC = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController,
                let vc = self?.detailViewController {
                
                let state = DetailItemViewState.init(desc: product.description ?? product.title,
                                                     price: product.regularPrice.displayPrice,
                                                     image: URL.init(string: product.imageURL),
                                                     salePrice: product.salePrice?.displayPrice)
                self?.viewState.listItems = [state] as [DetailItemViewState]
                rootVC.present(vc,
                               animated: true,
                               completion: nil)
            }
        }
    }
}
