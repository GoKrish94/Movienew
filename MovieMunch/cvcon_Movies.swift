//
//  cvcon_Movies.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit


private let reuseIdentifier = "MovieCell"

@available(iOS 10.0, *)
class cvcon_Movies: UICollectionViewController ,UICollectionViewDelegateFlowLayout   {
var MovieArray:NSMutableArray = NSMutableArray()
var NumberofRows:Int = 0
var appDelegate = UIApplication.shared.delegate as! AppDelegate
@IBOutlet var cv: UICollectionView!
func applyLayout(){
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    
}


override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
}

func setupMovies(){
    
    
    addMovietoArray(title:"Atomic Blonde",img:"atomic-blonde-t-poster-gallery.jpg")
    addMovietoArray(title:"Despicable Me 3",img:"despicable_me_three_poster.jpeg")
    addMovietoArray(title:"Get Out",img:"get_out_poster.jpeg")
    addMovietoArray(title:"Life",img:"life-full1.jpg")
    addMovietoArray(title:"Sleight",img:"sleight-poster.jpeg")
    addMovietoArray(title:"T2 Trainspotting Two",img:"t_two_trainspotting_renton.jpeg")
    addMovietoArray(title:"The Circle",img:"the-circle-poster.jpeg")
    addMovietoArray(title:"Star Wars Episode VIII:The Last Jedi",img:"the-last-jedi.jpg")
    
    cv.reloadData()
    
}

func addMovietoArray(title:String,img:String){
    let poster = UIImage(named: img)
    _ = UIImageView.init(image: poster)
    let  mov = Movie(title: title, poster: img)
    MovieArray.add(mov)
    
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}







//MARK : - View Stuff


func goBackToVideoPlayer(){
    
    
}
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    setupMovies()
    return MovieArray.count
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var imagefull:UIImage  = UIImage()
    let moviecell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    
    let tempmov=MovieArray.object(at: indexPath.row) as! Movie
    
    
    
    
    //
    
    
    
    
    let img:UIImageView = moviecell.viewWithTag(301) as! UIImageView
    let lbl:UILabel =  moviecell.viewWithTag(201) as! UILabel
    let image = UIImage.init(named: tempmov.MoviePoster!)
    img.image = image
    
    let str = tempmov.MovieTitle
    
    //+ "-" +  tempmov.genres!
    
    
    lbl.text = str
    
    
    
    
    
    
    return moviecell
    
}


override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    let del = UIApplication.shared.delegate as! AppDelegate
    
    
    del.currentMovie = MovieArray.object(at: indexPath.row) as? Movie
    
    //Move to next View
    
    
    
}
override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    var displaycell = cell
    
    //displaycell.frame = CGRect(x:displaycell.frame.origin.x, y: displaycell.frame.height + 1, width: displaycell.frame.width, height: displaycell.frame.height)
    let lbl1 = cell.viewWithTag(201) as! UILabel
    let  img = cell.viewWithTag(301) as! UIImageView
    
    img.alpha = 0
    lbl1.alpha = 0
    
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
        
        img.alpha = 1
        lbl1.alpha = 1
        //displaycell.frame = CGRect(x: displaycell.frame.origin.x, y: displaycell.frame.origin.y, width: displaycell.frame.width, height: displaycell.frame.height)
        
    })
    
}

}


