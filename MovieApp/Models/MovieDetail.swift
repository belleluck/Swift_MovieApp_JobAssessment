//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import Foundation

class MovieDetail {
    
    // imdb uinique
    var id: String
    var movieTitle: String
    var movieYear: Int
    var movieGenre: String
    var imdbRating: Float
    var imdbVotes: String
    var moviePlot: String
    var imgPosterURL: String
    var otherRatingSource: [MovieDetailRatingItem]
    
    init() {
        id = ""
        movieTitle = ""
        movieYear = 0
        movieGenre = ""
        imdbRating = 0.0
        imdbVotes = ""
        moviePlot = ""
        imgPosterURL = ""
        otherRatingSource = []
    }
    
    init(id: String, movieTitle: String, movieYear: Int, movieGenre: String, imdbRating: Float, imdbVotes: String, moviePlot: String, imgPosterURL: String, otherRatingSource: [MovieDetailRatingItem]) {
        self.id = id
        self.movieTitle = movieTitle
        self.movieYear = movieYear
        self.movieGenre = movieGenre
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.moviePlot = moviePlot
        self.imgPosterURL = imgPosterURL
        self.otherRatingSource = otherRatingSource
    }
    
}
