//
//  cvcon_MovieTimes.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/16/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuItemCell"

class cvcon_MainMenu: UICollectionViewController {
@IBOutlet var cv:UICollectionView!
var selectedvalue  = NSInteger()
var menuitems = ["PopCorn","Drinks","Combo","HotFood","Candy","IceCream"]
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
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
    return menuitems.count
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    let lbl1 = cell.viewWithTag(201) as! UILabel
    let  img = cell.viewWithTag(301) as! UIImageView
    
    
    lbl1.text = menuitems[indexPath.row]
    
    switch menuitems[indexPath.row] {
    case "PopCorn":
        img.image = UIImage(named: "PopCorn")
    case "Drinks":
        img.image = UIImage(named: "Drinks")
    case "Combo":
        img.image = UIImage(named: "Combo")
    case "HotFood":
        img.image = UIImage(named: "HotFood")
    //img.image = UIImage(named: "PopCorn")
    case "Candy":
        img.image = UIImage(named: "Candy")
    //img = UIImage(named: "Candy")
    case "IceCream":
        img.image = UIImage(named: "IceCream")
    //img = UIImage(named: "IceCream")
    default:
        break
        //  img.image = UIImage(named: "IceCream")
    }
    
    
    
    //img.image = getMenuImage(text: menuitems[indexPath.row])
    
    return cell
}
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedvalue = indexPath.row
        
            let stringImageName    = menuitems[indexPath.row] as? String

        UserDefaults.standard.setValue(stringImageName, forKey: "stringImageName")


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



func getMenuImage(text:String )->UIImage{
    
    
    var img:UIImage? = UIImage()
    
    //= UIImage()
    //["Popcorn","Drinks","Combo's","Hot Food","Candy","Ice Cream"]
    switch text {
    case "Popcorn":
        img = UIImage(named: "PopCorn")
    case "Drinks":
        img = UIImage(named: "PopCorn")
    case "Combo's":
        img = UIImage(named: "PopCorn")
    case "Hot Food":
        //img = UIImage(named: "HotFood")
        img = UIImage(named: "PopCorn")
    case "Candy":
        img = UIImage(named: "PopCorn")
    //img = UIImage(named: "Candy")
    case "Ice Cream":
        img = UIImage(named: "PopCorn")
    //img = UIImage(named: "IceCream")
    default:
        img = UIImage(named: "IceCream")
    }
    
    return img!
}


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "pushtotvcon_Products" {
            if #available(iOS 10.0, *) {
                if let object = segue.destination as? tvcon_Products {
                    object.imageString = menuitems[selectedvalue] as NSString
                    print(object.imageString)

                    
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
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
