//
//  AppURL.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 01/09/2023.
//

import Foundation

struct AppURL {
    
    struct Domain {
    
        static let OMDB_ServerURL = "http://www.omdbapi.com"
    }
    
    private static let apiKey = "6fc87060"
    
    public func GetSearchedMovieList(searchText: String) -> String {
//    http://www.omdbapi.com/?apikey=6fc87060&s=Marvel&type=movie
        return "\(Domain.OMDB_ServerURL)/?apikey=\(AppURL.apiKey)&s=\(searchText)&type=movie"
    }
    
    public func GetSingleMovieDetail(movieID: String) -> String {
//    http://www.omdbapi.com/?apikey=6fc87060&i=tt4154664
        return "\(Domain.OMDB_ServerURL)/?apikey=\(AppURL.apiKey)&i=\(movieID)"
    }

}
