//
//  DetailView.swift
//  ProductViewer
//
//  Created by Kalyani Chinchane on 23/08/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit
import Tempo

final class DetailView: UIView {
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buttonAddToCart: UIButton!
    @IBOutlet weak var buttonAddToList: UIButton!
    
    @IBAction func addToCart(_ sender: Any) {
        //
    }
    @IBAction func addToList(_ sender: Any) {
        //
    }
}

extension DetailView: ReusableNib {
    @nonobjc static let nibName = "DetailView"
    @nonobjc static let reuseID = "DetailViewIdentifier"

    @nonobjc func prepareForReuse() {
        //
    }
}
