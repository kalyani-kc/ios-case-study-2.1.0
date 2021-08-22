//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
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
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    var serviceHelper: ServiceEntity?
    
    var detailCoordinator: DetailCoordinator?
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        serviceHelper = Service()
        updateState()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            self?.detailCoordinator = DetailCoordinator(detailID: e.item.prodId)
        }
    }
    
    func updateState() {
        var deals: Deals?
        serviceHelper?.getListOfDeals(completion: { [weak self] (response, error) in
            deals = response
            if let prods = deals?.products {
                self?.viewState.listItems = prods.map({ (product) -> ListItemViewState in
                    ListItemViewState(title: product.title,
                                      price: product.regularPrice.displayPrice,
                                      image: URL.init(string: product.imageURL),
                                      prodId: String(product.id))
                }) as [ListItemViewState]
            }
        })
    }
}
