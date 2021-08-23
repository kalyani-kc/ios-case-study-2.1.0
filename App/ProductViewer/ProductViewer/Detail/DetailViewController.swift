//
//  DetailViewController.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

class DetailListViewController: UIViewController {
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailListViewController {
        let viewController = DetailListViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    fileprivate var coordinator: TempoCoordinator!
    
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .none,
                                                                   right: .none,
                                                                   bottom: .narrow,
                                                                   left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .none,
                                                                   right: .none,
                                                                   bottom: .none,
                                                                   left: .none)
        harmonyLayout.defaultItemMargins = HarmonyLayoutMargins(top: .none,
                                                                right: .none,
                                                                bottom: .none,
                                                                left: .none)
        harmonyLayout.defaultItemHeight = self.view.bounds.height
        
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetStarkWhiteColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
                
        let components: [ComponentType] = [
            DetailComponent()
        ]
        
        let componentProvider = ComponentProvider(components: components,
                                                  dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        
        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]

    }
}

