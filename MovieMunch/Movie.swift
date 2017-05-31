//
//  Movie.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var MovieTitle:String?
    var MoviePoster:String?
    
    init (title:String,poster:String){
    self.MovieTitle = title
    self.MoviePoster = poster
        
    }
}
