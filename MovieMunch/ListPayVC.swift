//
//  ListPayVC.swift
//  MovieMunch
//
//  Created by Anil Kumar on 17/05/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

class ListPayVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIScrollViewDelegate{

var def = UserDefaults()

@IBOutlet var OrderDetailsButton: UIButton!
@IBOutlet var FoodndDrinksButton: UIButton!
var array = NSMutableArray()
var priceArray = NSMutableArray()
var TotalPriceString = String()
var hidden = String()
var FixedScrollValue = NSString()



@IBOutlet var PAY: UIButton!
@IBOutlet var PayLabel: UILabel!

@IBOutlet var tableView: UITableView!
var orders: [Order]? {
    didSet {
        
    }
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
        PAY.setTitle("PAY:$ 0",for: .normal)

        
    }
    
    
    
    print("run")
    
    
    orders = Orders.readOrdersFromArchive()
    tableView.reloadData()
    
    
}
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        FixedScrollValue = "YES"
    }



override func viewDidLoad() {
    super.viewDidLoad()
    PAY.layer.cornerRadius = 5
    PAY.layer.borderWidth = 3
    PAY.layer.borderColor = UIColor.white.cgColor
    
    
    
    array = (UserDefaults.standard.value(forKey: "ItemList")  as! NSArray).mutableCopy() as! NSMutableArray
    print(array)
    tableView.delegate = self
    tableView.dataSource = self
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    // 4
    //        let image = UIImage(named: "Combined Shape")
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    imageView.image = image
    // 5
    navigationItem.titleView = imageView
    
    var images = UIImage(named: "Untitle")
    
    images = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationController?.navigationBar.barTintColor = UIColor.red
    
    if(array.count == 0){
    PAY.setTitle("PAY:$ 0",for: .normal)
    }
    
    // Do any additional setup after loading the view.
}

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
}



func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier: String = "Cell"
    let cell: ListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        as! ListTableViewCell?
    
    
    let str4 = (self.array.value(forKey: "Image") as AnyObject).object(at: indexPath.row)  as? String
    let str = (self.array.value(forKey: "Foodname") as AnyObject).object(at: indexPath.row)  as? String
    let str1 = (self.array.value(forKey: "Price") as AnyObject).object(at: indexPath.row)  as? String
    let str2 = (self.array.value(forKey: "Quantity") as AnyObject).object(at: indexPath.row)  as? Int
    
    let str3: String = str1!.replacingOccurrences(of: "$", with: "")
    
    let num = Double(str3)
    let num1 = Double(str2!)
    
    
    cell?.imageview.image  = UIImage(named:str4!)
    
    cell?.NameLabel.text = "\(str2! as Int) \("X") \(str! as String)" as String
    cell?.PriceLabel.text = "\("$") \(num1*num!)"
    
    
    let num2 = num1*num!
    print(num2)
    let num3: NSNumber = num2 as NSNumber
    
    
    print(FixedScrollValue)

    if FixedScrollValue.isEqual(to: "YES") {
        print(priceArray.count)
    }
    else{
        priceArray.add(num3)

    }
    
    
    
    var total: Float = 0
    
    for str:AnyObject in priceArray as [AnyObject]{
        total += CFloat(str as! NSNumber)
        print(total)
        TotalPriceString = String(total)
        
    }
    PAY.setTitle("PAY:$\(TotalPriceString)",for: .normal)
    
    cell?.removelabel.tag = indexPath.row
    cell?.removelabel.addTarget(self, action: #selector(self.deleteItem), for: .touchUpInside)
    
    return cell!
}

func deleteItem(_ sender: UIButton) {
    print(sender.tag)
    array.removeObject(at: sender.tag)
    priceArray.removeAllObjects()
    UserDefaults.standard.setValue(priceArray, forKey: "priceList")
    
    UserDefaults.standard.setValue(array, forKey: "ItemList")
    print(array.count)
    if array.count == 0{
    PAY.setTitle("PAY:$ 0",for: .normal)
    }
    FixedScrollValue = "NO"

    tableView.reloadData()
}
func addTappedd(sender: UIBarButtonItem){
    
}
    
    
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        // Delete the row from the data source
        
        orders?.remove(at: indexPath.row)
        
        if let orders = orders {
            let _ = Orders.saveOrdersToArchive(orders: orders)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


override func prepare(for segue: UIStoryboardSegue, sender: Any?)
{
    if segue.identifier == "pushToPayment" {
        if let object = segue.destination as? LoginViewController {
            object.costStr = TotalPriceString as NSString
            
        }
    }
}


}

