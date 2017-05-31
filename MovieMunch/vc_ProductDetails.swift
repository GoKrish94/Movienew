//
//  vc_ProductDetails.swift
//  MovieMunch
//
//  Created by Curtiss Pope on 3/23/17.
//  Copyright © 2017 INDCG. All rights reserved.
//

import UIKit



@available(iOS 10.0, *)
class vc_ProductDetails: UIViewController {
    var arrayItems = NSMutableArray()
    var rightBarButton: ENMBadgedBarButtonItem?
    var def = UserDefaults()
    var Pricevalue = String()
    var quantity1 = Int()
    @IBOutlet var FoodImage: UIImageView!
    @IBOutlet var count: UILabel!
    var appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var btnAddToCart: UIButton!
    var quantity:[Int] = [1,2,3,4,5,6,7,8,9,10,11]
    var number = Int()
    var numberString = String()
    
    @IBOutlet var Notify: UIButton!
    var product: Product?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let prefs = UserDefaults.standard
        let object: NSObject? = prefs.object(forKey: "ItemList") as! NSObject?
        if object != nil {
            arrayItems = (UserDefaults.standard.value(forKey: "ItemList")  as! NSArray).mutableCopy() as! NSMutableArray
            print(arrayItems)
            //object is there
        }
        else
        {
            print("Cart is empty")
            
        }
        
        
        
        let myInt = String(arrayItems.count)
        rightBarButton?.badgeValue = myInt
        
    }
    
    
    
    override func viewDidLoad() {
        setUpLeftBarButton()
        lblProductName.text = appDelegate.currentFoodItem?.FoodName
        
        
        product?.price = UserDefaults.standard.value(forKey: "Pricevalue") as? Double
        product?.name = UserDefaults.standard.value(forKey: "quantity") as? String
        let imageString = UserDefaults.standard.value(forKey: "stringImageName") as! NSString
        
        FoodImage.image = UIImage(named:imageString as String)
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.red
        Notify.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.image = image
        navigationItem.titleView = imageView
        var images = UIImage(named: "Untitle")
        images = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        
        stylizeBtn()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpLeftBarButton() {
        let image = UIImage(named: "Untitle")
        let button = UIButton(type: .custom)
        if let knownImage = image {
            button.frame = CGRect(x: 50.0, y: 0.0, width: knownImage.size.width, height: knownImage.size.height)
        } else {
            button.frame = CGRect.zero;
        }
        
        button.setBackgroundImage(image, for: UIControlState())
        button.addTarget(self,
                         action: #selector(vc_ProductDetails.leftButtonPressed(_:)),
                         for: UIControlEvents.touchUpInside)
        
        let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "\(count)")
        rightBarButton = newBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    func leftButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushToListVc", sender: self)
    }
    
    
    @IBAction func AddtoCart(_ sender: AnyObject) {
        let prefs = UserDefaults.standard
        let object: NSObject? = prefs.object(forKey: "Pricevalue") as! NSObject?
        let object1: NSObject? = prefs.object(forKey: "quantity") as! NSObject?
        
        if object != nil && object1 != nil {
            Pricevalue = UserDefaults.standard.value(forKey: "Pricevalue") as! String
            quantity1 = UserDefaults.standard.value(forKey: "quantity") as! Int
            print(Pricevalue)
            print(quantity1)
        }
        else
        {
            print("Cart is empty")
            
        }
        
        
        
        product?.price = UserDefaults.standard.value(forKey: "Pricevalue") as? Double
        product?.name = UserDefaults.standard.value(forKey: "quantity") as? String
        
        
        
        if Pricevalue == "" || quantity1 == 0{
            let alertController = UIAlertController(title: "Oops!", message: "Please Select the Size & Quantity", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            let foodname = (appDelegate.currentFoodItem?.FoodName!)! as String
            print((appDelegate.currentFoodItem?.FoodImage)! as String)
            print((appDelegate.currentFoodItem?.FoodName)! as String)
            print("Button tapped")
            
            let order = Order()
            order.order_id = 1
            order.product = product
            
            
            var orders = Orders.readOrdersFromArchive()
            
            let imageString = UserDefaults.standard.value(forKey: "stringImageName") as! NSString
            
            print(imageString)
            
            let populatedDictionary = [ "Foodname": foodname,"Price": Pricevalue, "Quantity": quantity1,"Image": imageString] as [String : Any]
            
            UserDefaults.standard.removeObject(forKey: "quantity")
            UserDefaults.standard.removeObject(forKey: "Pricevalue")
            
            
            print(populatedDictionary)
            
            arrayItems .add(populatedDictionary)
            
            print(arrayItems.count)
            print(arrayItems)
            
            
            def = UserDefaults .standard
            
            UserDefaults.standard.setValue(arrayItems, forKey: "ItemList")
            
            let myInt = String(arrayItems.count)
            
            rightBarButton?.badgeValue = myInt
            
            
            if(orders == nil) {
                orders = [order]
            } else {
                orders?.append(order)
            }
            
            if let orders = orders {
                if(Orders.saveOrdersToArchive(orders: orders)) {
                    //present(alertController, animated: true, completion: nil)
                }
            }
            
        }
        
        
        
    }
    
    func stylizeBtn(){
        
        btnAddToCart.layer.borderWidth = 2
        btnAddToCart.layer.borderColor = UIColor.white.cgColor
        btnAddToCart.backgroundColor = UIColor.clear
        btnAddToCart.layer.cornerRadius = 6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "pushToListVc" {
    //            if let object = segue.destination as? ListPayVC {
    //                
    //                object.array = (self.arrayItems as NSMutableArray)
    //                
    //            }
    //        }
    //    }
    
}
