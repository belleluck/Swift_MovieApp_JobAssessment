//
//  MovieDB.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 01/09/2023.
//

import Foundation
import SQLite

class MovieDB {
    static let instance = MovieDB()
    
    private let db: Connection?
    
    private let tableMovie = Table("tableMovie")
    
    private let row_id = Expression<Int>("row_id")
    private let movie_title = Expression<String>("movie_title")
    private let movie_type = Expression<String>("movie_type")
    private let movie_year = Expression<Int>("movie_year")
    private let imdb_id = Expression<String>("imdb_id")
    private let poster_url = Expression<String>("poster_url")
    private let poster_data = Expression<String>("poster_data")
    
    private init() {
        let dbName: String = "MovieDB"
        
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
            try db!.run(tableMovie.drop(ifExists: true))
        } catch {
            print("Update tableMovie Error")
            print(error.localizedDescription)
        }
//        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(tableMovie.create(ifNotExists: true) { t in
                t.column(row_id, primaryKey: true)
                t.column(movie_title)
                t.column(movie_type)
                t.column(movie_year)
                t.column(imdb_id)
                t.column(poster_url)
                t.column(poster_data)
            })
        } catch {
            print("MovieDB createTable error: \(error)")
        }
    }
    
    func addMovie(movie: Movie) {
        do {
            try db!.run(tableMovie.insert(
                movie_title  <- movie.movieTitle,
                movie_type   <- movie.movieType,
                movie_year   <- movie.movieYear,
                imdb_id      <- movie.imdbID,
                poster_url   <- movie.posterURL,
                poster_data  <- movie.posterData
            ))
        } catch {
            print("Insert movie to db failed: \(error.localizedDescription)")
        }
    }
    
    func updatePosterData(dataString: String) {
        do {
            try db!.run(tableMovie.update(poster_data <- dataString))
        } catch {
            print("updatePosterData failed: \(error.localizedDescription)")
        }
    }
    
    func getAllMovie() -> [Movie] {
        var movies = [Movie]()
        do {
            for movie in try db!.prepare(self.tableMovie) {
                movies.append(
                    Movie(
                        movieTitle: movie[movie_title],
                        movieType: movie[movie_type],
                        movieYear: movie[movie_year],
                        imdbID: movie[imdb_id],
                        posterURL: movie[poster_url],
                        posterData: movie[poster_data]
                    )
                )
            }
        } catch {
            print("getAllMovie Failed: \(error.localizedDescription)")
        }
        return movies
    }
    
    
    func deleteMovie() {
        do {
            try db!.run(tableMovie.delete())
            print("Movie Table Deleted")
        } catch {
            print("deleteMovie Failed: \(error.localizedDescription)")
        }
    }
}
