//
//  Movie.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class FoodItem: NSObject {
   
    var FoodName:String?
    var FoodPrice:String?
    var FoodDesc:String?
    var FoodImage:String?
    var FoodSizes:[String]?
    
    init (name:String,price:String,desc:String, image:String,sizes:[String]){
        self.FoodName = name
        self.FoodPrice = price
        self.FoodDesc = desc
        self.FoodImage = image
        self.FoodSizes = sizes
    }
}
