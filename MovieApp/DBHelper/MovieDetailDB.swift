//
//  MovieDetailDB.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import Foundation
import SQLite

class MovieDetailDB {
    static let instance = MovieDetailDB()
    
    private let db: Connection?
    
    private let tableMovieDetail = Table("tableMovieDetail")
    private let tableMovieDetailRatingItem = Table("tableMovieDetailRatingItem")
    
    private let row_id = Expression<Int>("row_id")
    private let movie_id = Expression<String>("movie_id")
    
    private let movie_title = Expression<String>("movie_title")
    private let movie_year = Expression<Int>("movie_year")
    private let movie_genre = Expression<String>("movie_genre")
    private let imdb_rating = Expression<String>("imdb_rating")
    private let imdb_votes = Expression<String>("imdb_votes")
    private let movie_plot = Expression<String>("movie_plot")
    private let img_poster_url = Expression<String>("img_poster_url")
    
    private let display_order = Expression<Int>("display_order")
    private let rating_source = Expression<String>("rating_source")
    private let rating_value = Expression<String>("rating_value")
    
    private init() {
        let dbName: String = "MovieDetailDB"
        
        do {
            db = try Connection("\(URL.documentsDirectory.path)/\(dbName).sqlite3")
        } catch {
            db = nil
            print("MovieDB init error: \(error)")
        }
        createTable()
    }
    
    func getDbVersion() -> Int {
        return db!.userVersion
    }
    
    func setDbVersion(version: Int) {
        db!.userVersion = version
    }
    
    func updateTable() {
        do {
            try db!.run(tableMovieDetail.drop(ifExists: true))
            try db!.run(tableMovieDetailRatingItem.drop(ifExists: true))
        } catch {
            print("Update tableMovieDetail Error")
            print(error.localizedDescription)
        }
//        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(tableMovieDetail.create(ifNotExists: true) { t in
                t.column(row_id, primaryKey: true)
                t.column(movie_id)
                t.column(movie_title)
                t.column(movie_year)
                t.column(movie_genre)
                t.column(imdb_rating)
                t.column(imdb_votes)
                t.column(movie_plot)
                t.column(img_poster_url)
            })
            
            try db!.run(tableMovieDetailRatingItem.create(ifNotExists: true) { t in
                t.column(row_id, primaryKey: true)
                t.column(movie_id)
                t.column(display_order)
                t.column(rating_source)
                t.column(rating_value)
            })
        } catch {
            print("MovieDetailDB createTable error: \(error)")
        }
    }
    
    func addMovieDetail(movieDetail: MovieDetail) {
        do {
            try db!.run(tableMovieDetail.insert(
                movie_id        <- movieDetail.id,
                movie_title     <- movieDetail.movieTitle,
                movie_year      <- movieDetail.movieYear,
                movie_genre     <- movieDetail.movieGenre,
                imdb_rating     <- "\(movieDetail.imdbRating)",
                imdb_votes      <- movieDetail.imdbVotes,
                movie_plot      <- movieDetail.moviePlot,
                img_poster_url  <- movieDetail.imgPosterURL
            ))
            
            for item in movieDetail.otherRatingSource {
                try db!.run(tableMovieDetailRatingItem.insert(
                    movie_id        <- item.id,
                    display_order   <- item.displayOrder,
                    rating_source   <- item.ratingSource,
                    rating_value    <- item.ratingValue
                ))
            }
            
        } catch {
            print("Insert movie to MovieDetailDB failed: \(error.localizedDescription)")
        }
    }
    
    func getMovieDetailByID(movieID: String) -> MovieDetail {
        var movieDetail: MovieDetail = MovieDetail()
        do {
            
            for item in try db!.prepare(tableMovieDetail.filter(movie_id == movieID)) {
                
                var mDetailRatingItems: [MovieDetailRatingItem] = []
                
                for child in try db!.prepare(tableMovieDetailRatingItem.filter(movie_id == movieID).order(display_order)) {
                    mDetailRatingItems.append(
                        MovieDetailRatingItem(
                            id: child[movie_id],
                            displayOrder: child[display_order],
                            ratingSource: child[rating_source],
                            ratingValue: child[rating_value]
                        )
                    )
                }
                
                let rating = Float(item[imdb_rating])!
                let ratingString = String(format: "%.1f", rating)
                
                movieDetail = MovieDetail(
                    id: item[movie_id],
                    movieTitle: item[movie_title],
                    movieYear: item[movie_year],
                    movieGenre: item[movie_genre],
                    imdbRating: Float(ratingString)!,
                    imdbVotes: item[imdb_votes],
                    moviePlot: item[movie_plot],
                    imgPosterURL: item[img_poster_url],
                    otherRatingSource: mDetailRatingItems
                )
            }
        } catch {
            print("getMovieDetailByID Failed: \(error.localizedDescription)")
        }
        return movieDetail
    }
    
    func getCount() -> Int {
        var count: Int = 0
        
        do {
            count = try Int((db?.scalar(tableMovieDetail.count))!)
        } catch {
            print("getCount in movie detail db failed: \(error.localizedDescription)")
        }
        
        return count
    }
    
    func deleteMovieDetail() {
        do {
            try db!.run(tableMovieDetail.delete())
            try db!.run(tableMovieDetailRatingItem.delete())
            print("MovieDetail Table Deleted")
        } catch {
            print("deleteMovieDetail Failed: \(error.localizedDescription)")
        }
    }
}
