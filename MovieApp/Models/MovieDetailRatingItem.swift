//
//  MovieDetailRatingItem.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import Foundation

class MovieDetailRatingItem {
    
    var id: String
    var displayOrder: Int
    var ratingSource: String
    var ratingValue: String
    
    init() {
        self.id = ""
        self.displayOrder = 0
        self.ratingSource = ""
        self.ratingValue = ""
    }
    
    init(id: String, displayOrder: Int, ratingSource: String, ratingValue: String) {
        self.id = id
        self.displayOrder = displayOrder
        self.ratingSource = ratingSource
        self.ratingValue = ratingValue
    }
    
}
