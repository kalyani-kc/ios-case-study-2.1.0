//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable {
    let title: String
    let price: String
    let image: URL?
    let prodId: String
    let salePrice: String?
}

func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.image == rhs.image
        && lhs.prodId == rhs.prodId
        && lhs.salePrice == rhs.salePrice
}

struct DetailViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

struct DetailItemViewState: TempoViewStateItem, Equatable {
    let desc: String
    let price: String
    let image: URL?
    let salePrice: String?
}

func ==(lhs: DetailItemViewState, rhs: DetailItemViewState) -> Bool {
    return lhs.price == rhs.price
        && lhs.desc == rhs.desc
        && lhs.image == rhs.image
        && lhs.salePrice == rhs.salePrice
}
