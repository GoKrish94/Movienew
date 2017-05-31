//
//  cvcon_MovieTimes.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FoodPriceCell"


class cvcon_FoodPrices: UICollectionViewController {
@IBOutlet var cv:UICollectionView!
var foodPriceArray:NSMutableArray = NSMutableArray()
var def = UserDefaults()


// let appDelegate = UIApplicationDelegate.self

override func viewDidLoad() {
    super.viewDidLoad()
    var image = UIImage(named: "Untitle")
    
    image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: nil, action: #selector(addTapped))
    
    navigationController?.navigationBar.barTintColor = UIColor.red
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
}
func addTapped(){
    
    let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "ListPayVC") as? ListPayVC
    self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    
    
}


override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    
    addFoodPricesToArray(size: "Small", price: "$4.99")
    addFoodPricesToArray(size: "Medium", price: "$4.99")
    addFoodPricesToArray(size: "Large", price: "$4.99")
    
    cv.reloadData()
    
    
}

func addFoodPricesToArray(size:String,price:String){
    
    let fp:FoodPrice = FoodPrice(size: size, price: price)
    
    foodPriceArray.add(fp)
    
    
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
    
    addFoodPricesToArray(size: "Small", price: "$4.99")
    addFoodPricesToArray(size: "Medium", price: "$8.99")
    addFoodPricesToArray(size: "Large", price: "$12.99")
    addFoodPricesToArray(size: "Maxi", price: "$3.99")
    addFoodPricesToArray(size: "Jumbo", price: "$15.99")
    return foodPriceArray.count
    
    
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    let fp = foodPriceArray[indexPath.row] as! FoodPrice
    
    let lbl1 = cell.viewWithTag(201) as! UILabel
    let lbl2 = cell.viewWithTag(202) as! UILabel
    // Configure the cell
    
    cell.layer.borderWidth = 2
    cell.layer.borderColor = UIColor.white.cgColor
    cell.backgroundColor = UIColor.clear
    cell.layer.cornerRadius = 6
    lbl1.text = fp.Size
    lbl2.text = fp.Price
    
    
    return cell
}

override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    let fp = foodPriceArray[indexPath.row] as! FoodPrice
    let lbl2 = cell?.viewWithTag(202) as! UILabel
    lbl2.text = fp.Price!
    let Pricevalue = lbl2.text! as String
    NSLog("did select and the text is \(Pricevalue)")
    def = UserDefaults .standard
    UserDefaults.standard.setValue(Pricevalue, forKey: "Pricevalue")
    
    for cellx in cv.visibleCells {
        cellx.layer.borderWidth = 2
        cellx.layer.borderColor = UIColor.white.cgColor
        cellx.backgroundColor = UIColor.clear
        cellx.layer.cornerRadius = 6
    }
    
    cell?.backgroundColor = UIColor.red
    cell?.layer.borderColor = UIColor.red.cgColor
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
