//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var ratingTableView: UITableView!
    
    var selectedMovieID: String = ""
//    var selectedMovieDetail: MovieDetail = MovieDetail()
    
    lazy var movieRatingItems: [MovieDetailRatingItem] = {
        let movieDetail = MovieDetailDB.instance.getMovieDetailByID(movieID: selectedMovieID)
        return movieDetail.otherRatingSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\n\nThe selected movie ID is: \(selectedMovieID)")
//        dump(selectedMovieDetail)
        print("the movieRatingItems is: ")
        dump(movieRatingItems)
        
        ratingTableView.dataSource = self
        ratingTableView.delegate = self
//        ratingTableView.register(UINib(nibName: "MovieRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieRatingTableViewCell")
        ratingTableView.tableFooterView = UIView()
        ratingTableView.separatorStyle = .none
        
        title = "Movie Detail"
    }


}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRatingTableViewCell") as! MovieRatingTableViewCell
            cell.movieRatingItemsData = movieRatingItems
            
            return cell
//        }
//
//        let cell = UITableViewCell()
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
            return CGFloat(150)
//        }
//        return CGFloat(10)
    }
}
