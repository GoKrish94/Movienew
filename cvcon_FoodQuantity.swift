//
//  cvcon_MovieTimes.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FoodQuantityCell"

@available(iOS 10.0, *)
class cvcon_FoodQuantity: UICollectionViewController {
@IBOutlet var cv:UICollectionView!
var quantity:[Int] = [1,2,3,4,5,6,7,8,9,10,11]
var selectedQuantity = 0
var def = UserDefaults()

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    
    cv.reloadData()
    
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

// MARK: UICollectionViewDataSource



override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return quantity.count
}


override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    
    let Selectedquantity = quantity[indexPath.row]
    def = UserDefaults .standard
    UserDefaults.standard.setValue(Selectedquantity, forKey: "quantity")
    let cell = collectionView.cellForItem(at: indexPath)
    selectedQuantity = quantity[indexPath.row] - 1
    
    
    for cellx in cv.visibleCells {
        
        cellx.layer.borderWidth = 2
        cellx.layer.borderColor = UIColor.white.cgColor
        cellx.backgroundColor = UIColor.clear
        cellx.layer.cornerRadius = 6
    }
    
    cell?.backgroundColor = UIColor.red
    cell?.layer.borderColor = UIColor.red.cgColor
}
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    let lbl1 = cell.viewWithTag(201) as! UILabel
    // Configure the cell
    
    cell.layer.borderWidth = 2
    cell.layer.borderColor = UIColor.white.cgColor
    cell.backgroundColor = UIColor.clear
    cell.layer.cornerRadius = 6
    lbl1.text = String(quantity[indexPath.row])
    
    
    return cell
}




// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */

}
