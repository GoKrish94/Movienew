//
//  tvcon_Products.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/22/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class tvcon_Products: UITableViewController {


    
    
var imageString = NSString()

var productArray:NSMutableArray = NSMutableArray()
var NumberofRows:Int = 0

@IBOutlet weak var tv: UITableView!


override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    //   loadItems()
    
    
}



override func viewDidLoad() {
    super.viewDidLoad()
    
    
    print(imageString)
    
    // loadItems()
    
 }

func loadItems(){
    
    
    
    
    setupProductArray(FoodName: "Reese's Pieces", FoodPrice:"4",FoodDesc:"Reese's Pieces",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Skittles", FoodPrice:"4",FoodDesc:" Skittles",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " M&M Peanut or M&M Plain", FoodPrice:"4",FoodDesc:" M&M Peanut or M&M Plain",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Milk Duds", FoodPrice:"4",FoodDesc:"Milk Duds",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Kit Kat Bites", FoodPrice:"4",FoodDesc:" Kit Kat Bites",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Snickers Bites", FoodPrice:"4",FoodDesc:" Snickers Bites",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Starburst", FoodPrice:"4",FoodDesc:" Starburst",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Swedish Fish", FoodPrice:"4",FoodDesc:" Swedish Fish",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Junior Mints", FoodPrice:"4",FoodDesc:" Junior Mints",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Red Vines", FoodPrice:"4",FoodDesc:" Red Vines",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Sour Patch Kids", FoodPrice:"4",FoodDesc:"Sour Patch Kids",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: " Sour Patch Watermelon", FoodPrice:"4",FoodDesc:" Sour Patch Watermelon",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Popcorn-No Butter", FoodPrice:"3",FoodDesc:"Popcorn-No Butter",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Kettle Corn", FoodPrice:"5",FoodDesc:"Kettle Corn",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Popcorn-Extra Butter", FoodPrice:"6",FoodDesc:"Popcorn-Extra Butter",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Soft Drink-Small", FoodPrice:"2",FoodDesc:"Soft Drink-Small",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Soft Drink-Medium", FoodPrice:"4",FoodDesc:"Soft Drink-Medium",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Soft Drink-Large", FoodPrice:"6",FoodDesc:"Soft Drink-Large",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    setupProductArray(FoodName: "Ice Cream", FoodPrice:"3.25",FoodDesc:"Ice Cream",FoodImage:"nil", FoodSizes: ["Small","Medium","Large"])
    
    // self.tv.reloadData()
    // self.tableView.reloadData()
    
    
}

func setupProductArray(FoodName:String,
                       FoodPrice:String,
                       FoodDesc:String,
                       FoodImage:String,
                       FoodSizes:[String]){
    
    let p = FoodItem(name: FoodName, price: FoodPrice, desc: FoodDesc, image: FoodImage, sizes: FoodSizes)
    productArray.add(p)
    
    
    
    
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    
    loadItems()
    return 19
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell", for: indexPath)
    let p = productArray[indexPath.row] as! FoodItem
    cell.textLabel?.text = p.FoodName
    
    
    imageString = UserDefaults.standard.value(forKey: "stringImageName") as! NSString
    print(imageString)
    cell.imageView?.image = UIImage(named: imageString as String)
    return cell
}



override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
    
    appDelegate.currentFoodItem = productArray[indexPath.row] as? FoodItem
    
    var cell = self.tableView.cellForRow(at: indexPath)
    //   NSLog("did select and the text is \(cell?.textLabel?.text)")
    
    
    
    
    
    
}
func add(toCart sender: UIButton) {
    
}

/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
