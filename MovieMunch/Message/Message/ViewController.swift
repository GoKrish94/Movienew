import UIKit
import MessageUI // Import MessageUI
// Add the delegate protocol
class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    override func viewDidLoad() {
        sendMessage()
    }
    
    
    // Send a message
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Message String"
        messageVC.recipients = [] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true, completion: nil)
    }
    
    // Conform to the protocol
    // MARK: - Message Delegate method
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }}
