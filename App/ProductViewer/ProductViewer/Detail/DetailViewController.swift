//
//  DetailViewController.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 21/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

class DetailViewController: UIViewController {
    fileprivate var coordinator: TempoCoordinator!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var buttonAddToCart: UIButton!
    @IBOutlet weak var buttonAddToList: UIButton!
    var viewState: DetailItemViewState?
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
        let viewController = DetailViewController()
        viewController.coordinator = coordinator
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = viewState?.image
        productPrice.text = viewState?.price
        productDesc.text = viewState?.desc
        buttonAddToCart.setTitle("add to cart", for: .normal)
        buttonAddToList.setTitle("add to list", for: .normal)
        buttonAddToCart.backgroundColor = .targetBullseyeRedColor
        buttonAddToList.backgroundColor = .targetStrokeGrayColor
        buttonAddToCart.tintColor = .targetStarkWhiteColor
        buttonAddToList.tintColor = .targetBlackFridayCharcoalColor
        buttonAddToCart.layer.cornerRadius = 4
        buttonAddToList.layer.cornerRadius = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }

    @IBAction func addToCart(_ sender: Any) {
        //
    }
    @IBAction func addToList(_ sender: Any) {
        //
    }
    
}
