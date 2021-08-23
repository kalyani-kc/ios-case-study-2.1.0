//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ListViewController: UIViewController {
    var progressView: UIActivityIndicatorView?
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    fileprivate var coordinator: TempoCoordinator!
    
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .wide, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .wide, right: .none, bottom: .none, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetStarkWhiteColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        
        title = "checkout"
        
        let components: [ComponentType] = [
            ProductListComponent()
        ]
        
        let componentProvider = ComponentProvider(components: components,
                                                  dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        
        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]

    }
    func showProgressView() {
        DispatchQueue.main.async { [weak self] in
            self?.progressView = UIActivityIndicatorView.init(style: .large)
            if let activityIndicator = self?.progressView,
               let center = self?.view.center {
                self?.progressView?.center = center
                self?.progressView?.isHidden = false
                self?.view.addSubview(activityIndicator)
                self?.progressView?.startAnimating()
            }
        }
    }
    
    func hideProgressView() {
        DispatchQueue.main.async { [weak self] in
            if self?.progressView != nil {
                self?.progressView?.stopAnimating()
                self?.progressView?.isHidden = true
                self?.progressView?.removeFromSuperview()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}

