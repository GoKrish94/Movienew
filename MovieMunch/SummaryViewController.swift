//
//  SummaryViewController.swift
//  MovieMunch
//
//  Created by Anil Kumar on 25/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var array = NSMutableArray()
var priceArray = NSMutableArray()
var TotalPriceString = String()

@IBOutlet var tableView: UITableView!
override func viewDidLoad() {
    super.viewDidLoad()
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    // 4
    //        let image = UIImage(named: "Combined Shape")
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    imageView.image = image
    // 5
    navigationItem.titleView = imageView
    
    TotalAmountLabel.text = "$\(TotalPriceString)"
    // Do any additional setup after loading the view.
}
@IBOutlet var TotalAmountLabel: UILabel!

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let prefs = UserDefaults.standard
    let object: NSObject? = prefs.object(forKey: "ItemList") as! NSObject?
    if object != nil {
        array = (UserDefaults.standard.value(forKey: "ItemList")  as! NSArray).mutableCopy() as! NSMutableArray
        let object1: NSObject? = prefs.object(forKey: "priceList") as! NSObject?
        if object1 != nil {
            
            priceArray = (UserDefaults.standard.value(forKey: "priceList")  as! NSArray).mutableCopy() as! NSMutableArray
            
            print(priceArray)
        }//object is there
    }
    else
    {
        print("Cart is empty")
        
    }
    print("run")
    tableView.reloadData()
    
    
}

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
}



func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier: String = "Cell"
    let cell: SummaryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        as! SummaryTableViewCell?
    let str4 = (self.array.value(forKey: "Image") as AnyObject).object(at: indexPath.row)  as? String

    let str = (self.array.value(forKey: "Foodname") as AnyObject).object(at: indexPath.row)  as? String
    let str1 = (self.array.value(forKey: "Price") as AnyObject).object(at: indexPath.row)  as? String
    let str2 = (self.array.value(forKey: "Quantity") as AnyObject).object(at: indexPath.row)  as? Int
    
    let str3: String = str1!.replacingOccurrences(of: "$", with: "")
    
    let num = Double(str3)
    let num1 = Double(str2!)
    
    
    
    cell?.FoodImage.image  = UIImage(named:str4!)

    cell?.Name.text = "\(str2! as Int) \("X") \(str! as String)" as String
    cell?.Price.text = "\("$") \(num1*num!)"
    
    
    let num2 = num1*num!
    print(num2)
    let num3: NSNumber = num2 as NSNumber
    
    priceArray.add(num3)
    
    var total: Float = 0
    return cell!
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
