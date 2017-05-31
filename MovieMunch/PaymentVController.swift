//
//  ViewController.swift
//  MovieMunch
//
//  Created by Anil Kumar on 15/05/17.
//  Copyright © 2017 Atti. All rights reserved.
//

import UIKit
import Stripe
import UserNotifications
import PassKit
import Dispatch

class PaymentVController: UIViewController,STPAddCardViewControllerDelegate,PayPalPaymentDelegate,PKPaymentAuthorizationViewControllerDelegate,UNUserNotificationCenterDelegate{
@IBOutlet var totalAmount: UILabel!
var payPalConfig = PayPalConfiguration()

var totalCost = Double()
var costStr = NSString()

var acceptCreditCards : Bool = true{
    didSet {
        payPalConfig.acceptCreditCards = acceptCreditCards
    }
    
}


var environment: String = PayPalEnvironmentNoNetwork
    {
    willSet(newEnvironemt)
    {
        if (newEnvironemt != environment ){
            PayPalMobile.preconnect(withEnvironment: newEnvironemt)
        }
    }
}

@IBOutlet weak var applePay: UIButton!
let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]
var applePayMerchantID: String = "merchant.INDCG.com.INDCG.MovieMunch"
let ShippingPrice : NSDecimalNumber = NSDecimalNumber(string: "0.0")
var item: Item?
var merchantServerAddress: String = ""
var merchantServerPort: String = ""
var paypageId: String = ""
var eProtectUrl: String = ""
var eprotectHostHeader: String = ""
override func viewDidLoad() {
    
    print(self.costStr)
    if #available(iOS 10.0, *)
    {
        //Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options:       [.alert,.sound,.badge], completionHandler: {didAllow,Error in })
        UNUserNotificationCenter.current().delegate = self
    }
    
    
    
    totalAmount.text = "TotalAmount:$\(costStr as String)"
    
    
    payPalConfig.acceptCreditCards = acceptCreditCards;
    payPalConfig.merchantName = "HARIKARTHICK"
    payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.sivaganesh.com/privacy.html") as URL!
    payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.sivaganesh.com/useragreement.html") as URL!
    
    payPalConfig.languageOrLocale = NSLocale.preferredLanguages[0] as String
    payPalConfig.payPalShippingAddressOption = .payPal;
    PayPalMobile.preconnect(withEnvironment: environment)
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    imageView.contentMode = .scaleAspectFit
    // 4
    //        let image = UIImage(named: "Combined Shape")
    let image = UIImage(named: "Combined Shape")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    imageView.image = image
    // 5
    navigationItem.titleView = imageView
    
    
    super.viewDidLoad()
    
    
    applePay.isHidden = !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: SupportedPaymentNetworks)
    
    // Set up item
    if let item = item {
        navigationItem.title = item.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
    }
    
    // Read settings from plist
    let path = Bundle.main.path(forResource: "Settings", ofType: "plist")!
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
    let dict = plist as! [String:String]
    merchantServerAddress = dict["merchantServerAddress"]!
    merchantServerPort = dict["merchantServerPort"]!
    paypageId = dict["paypageId"]!
    eProtectUrl = dict["eProtectUrl"]!
    applePayMerchantID = dict["applePayMerchantID"]!
    eprotectHostHeader = dict["eprotectHostHeader"]!
    
    let clientTokenURL = URL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
    var clientTokenRequest = URLRequest(url: clientTokenURL)
    clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
    
    URLSession.shared.dataTask(with: clientTokenRequest) {
        (data, response, error) -> Void in
        // TODO: Handle errors
        let clientToken = String(data: data!, encoding: String.Encoding.utf8)
        // Initialize `Braintree` once per checkout session
        
        // As an example, you may wish to present our Drop-in UI at this point.
        // Continue to the next section to learn more...
        }.resume()
    
    super.viewDidLoad()
    var images = UIImage(named: "Untitle")
    
    images = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    
    // self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: nil, action: #selector(addTocart))
    
    navigationController?.navigationBar.barTintColor = UIColor.red
    
    // Do any additional setup after loading the view, typically from a nib.
}
@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
}
func initNotificationSetupCheck() {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    } else {
        // Fallback on earlier versions
    }
}
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
@IBAction func applepay(_ sender: AnyObject) {
    
    
    
    
    let request = PKPaymentRequest()
    request.merchantIdentifier = applePayMerchantID
    request.supportedNetworks = SupportedPaymentNetworks
    request.merchantCapabilities = PKMerchantCapability.capability3DS
    request.countryCode = "US"
    request.currencyCode = "USD"
    //request.requiredBillingAddressFields = PKAddressField.All
    request.requiredShippingAddressFields = PKAddressField.all
    
    //request.applicationData = "This is a test".dataUsingEncoding(NSUTF8StringEncoding)
    
    
    
    var decimal  = NSDecimalNumber()
    decimal = NSDecimalNumber(string: costStr as String)
    
    
    request.paymentSummaryItems = [
        
        
        
        
        PKPaymentSummaryItem(label: "Money", amount: decimal),
        PKPaymentSummaryItem(label: "Shipping", amount: ShippingPrice),
        
        PKPaymentSummaryItem(label: "Demo Merchant", amount:decimal)
    ]
    
    let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
    applePayController.delegate  = self;
    
    self.present(applePayController, animated: true, completion: nil)
    //        self.present(navigationController!, animated: true, completion: nil)
    
    
    
    
}



func alert()
{
    if #available(iOS 10.0, *) {
        let notification = UNMutableNotificationContent()
        notification.title = "Food&Drinks"
        notification.subtitle = "Total cost for your order:$\(self.costStr)"
        notification.body = "Your transaction have been successfully completed!"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    } else {
        // Fallback on earlier versions
    }
}


func Alertview()
{
    // Send payment method nonce to your server
    
    let alertController = UIAlertController(title: "Success", message: "Send payment method nonce to your server Sucessfully", preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        UIAlertAction in
        NSLog("OK Pressed")
        
        self.alert()
        
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController
        
        
        mapViewControllerObj?.TotalPriceString = self.costStr as String
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
        
    }
    
    // Add the actions
    alertController.addAction(okAction)
    
    // Present the controller
    
    if presentedViewController == nil {
        self.present(alertController, animated: true, completion: nil)
    } else{
        self.dismiss(animated: false) { () -> Void in
            self.present(alertController, animated: true, completion: nil)
        }
    }
}





@IBAction func actionAddCardDefault(_ sender: AnyObject) {
    
    let addCardViewController = STPAddCardViewController()
    
    addCardViewController.delegate = self
    // STPAddCardViewController must be shown inside a UINavigationController.
    let navigationController = UINavigationController(rootViewController: addCardViewController)
    self.present(navigationController, animated: true, completion: nil)
    
}

// MARK: STPAddCardViewControllerDelegate

func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
    self.dismiss(animated: true, completion: nil)
    
}

func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
    //Send token to backend for process
    print(token)
    
    self.dismiss(animated: true, completion: {
        completion(nil)
        self.Alertview()
        
    })
}

@IBAction func Paypal(_ sender: AnyObject) {
    let item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 1, withPrice: NSDecimalNumber(string:costStr as String), withCurrency: "USD", withSku: "Hip-0037")
    
    let items = [item1]
    let subtotal = PayPalItem.totalPrice(forItems: items)
    
    // Optional: include payment details
    let shipping = NSDecimalNumber(string: "0.00")
    let tax = NSDecimalNumber(string: "0.00")
    let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
    
    let total = subtotal.adding(shipping).adding(tax)
    
    let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Food & Drinks", intent: .sale)
    
    payment.items = items
    payment.paymentDetails = paymentDetails
    
    if (payment.processable){
        let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
        present(paymentViewController!, animated: true, completion: nil)
    }
    else {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
        print("Payment not processalbe: \(payment)")
    }
    
    
}

func userDidCancelPayment() {
    self.dismiss(animated: true, completion: nil)
}

func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
    self.dismiss(animated: true, completion: nil)
    
}
func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
    print("success")
    self.Alertview()
    
    
    DispatchQueue.global(priority: .background).async(execute: { () -> Void in
        
        
        completion(.success)
        
        
        
    })
}

//支付成功完成，并回调，移除控制器
func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    self.dismiss(animated: true, completion: nil)
    
    
}



func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
    print("success")
    paymentViewController.dismiss(animated: true) {
        print("Here is the proof of payment: \n\n\(completedPayment.confirmation)\n\nsend to your server")
        
        
     
        self.Alertview()
        
    }
}


}

func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
controller.dismiss(animated: true, completion: nil)
}

func convertStringToDictionary(text: NSString) -> [String:AnyObject]? {
if let data = text.data(using: String.Encoding.utf8.rawValue) {
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
    } catch let error as NSError {
        print(error)
    }
}
return nil
}




extension String {
func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
}
}
