//
//  Movie.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 01/09/2023.
//

import Foundation

class Movie {
    
    var movieTitle: String
    var movieType: String
    var movieYear: Int
    var imdbID: String
    var posterURL: String
    var posterData: String
    
    init() {
        self.movieTitle = ""
        self.movieType = ""
        self.movieYear = 0
        self.imdbID = ""
        self.posterURL = ""
        self.posterData = ""
    }
    
    init(movieTitle: String, movieType: String, movieYear: Int, imdbID: String, posterURL: String, posterData: String) {
        
        self.movieTitle = movieTitle
        self.movieType = movieType
        self.movieYear = movieYear
        self.imdbID = imdbID
        self.posterURL = posterURL
        self.posterData = posterData
    }
    
}
