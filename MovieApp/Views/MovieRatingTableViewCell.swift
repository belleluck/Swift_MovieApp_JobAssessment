//
//  MovieRatingTableViewCell.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import UIKit

class MovieRatingTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

//class MovieRatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var movieRatingItemsData: [MovieDetailRatingItem] = [MovieDetailRatingItem]() {
        didSet {
            mCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
//        mCollectionView.register(UINib(nibName: "MovieRatingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieRatingCollectionViewCell")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieRatingItemsData.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //let cell = UICollectionViewCell()
        //return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatingCollectionViewCell", for: indexPath) as! MovieRatingCollectionViewCell
        
        if (movieRatingItemsData.count > 0) {
            let ratingItem = movieRatingItemsData[indexPath.row]
            
            cell.mainRatingView.layer.cornerRadius = 15
            cell.mainRatingView.layer.masksToBounds = true

            cell.lblRatingSentence.text = ratingItem.ratingSource
            cell.lblRating.text = ratingItem.ratingValue
            cell.lblRating.isHidden = false
        }
        else {
            
            
            cell.mainRatingView.layer.cornerRadius = 15
            cell.mainRatingView.layer.masksToBounds = true

            cell.lblRatingSentence.text = "No other ratings"
            cell.lblRating.isHidden = true
        }
        
        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)

    }

}
