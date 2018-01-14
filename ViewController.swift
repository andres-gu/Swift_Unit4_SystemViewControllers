//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Andres Gutierrez on 1/13/18.
//  Copyright © 2018 Andres Gutierrez. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    ///// Share Button
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        print("share button tapped")
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
    }
    
    ///// Photos Button
    @IBAction func messageButtonTapped(_ sender: UIButton) {
        
        // Alert Controller to pick Mail or Messages
        let alertController = UIAlertController(title: "How do you want to send the message?", message: nil, preferredStyle: .actionSheet)
        
        // Mail button
        // - first checks if the device is able to send mail to present button to user.
        if !MFMailComposeViewController.canSendMail() {
            print("Cannot send mail")
        } else {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            let mailAction = UIAlertAction(title: "Mail", style: .default, handler: { action in
                
                // configuring fields of the interface
                mailComposer.setToRecipients(["example@example.com"])
                mailComposer.setSubject("Look at this")
                mailComposer.setMessageBody("Hello, this is an email from the app I made.", isHTML: false)
                
                // present the view controller modally
                self.present(mailComposer, animated: true, completion: nil)
            })
            // adds action to show "Mail" button in alert
            alertController.addAction(mailAction)
        }
        
        // Message button
        // - first checks if the device is able to send text messages to present button to user.
        if !MFMessageComposeViewController.canSendText() {
            print("Cannot send text message")
        } else {
            let messageComposer = MFMessageComposeViewController()
            messageComposer.messageComposeDelegate = self
            
            let messagesAction = UIAlertAction(title: "Messages", style: .default, handler: {action in
                
                // configuring fields of the interface
                messageComposer.recipients = ["---+++----"]
                messageComposer.body = "Hello, this is a message."
                
                // present the view controller modally
                self.present(messageComposer, animated: true, completion: nil)
            })
            // adds action to show "Message" button in alert
            alertController.addAction(messagesAction)
        }
        
        
        // Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        
        // in larger screens (ipads), this indicates the pop-over alert which item sent the request
        // and presents the view over that sender
        alertController.popoverPresentationController?.sourceView = sender
        
        // presents the alert
        present(alertController, animated: true, completion: nil)
    }
    
    // dismiss mail compose delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    // dismiss message compose delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
    
    ///// Safari Button
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "http://www.apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    ///// Photos Button
    @IBAction func photosButtonTapped(_ sender: UIButton) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Alert Controller to pick image source: image library or camera
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        // Camera button
        // - first checks if camera is available to be able to present button to user.
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            // adds action to show "Camera" button in alert
            alertController.addAction(cameraAction)
        }
        
        // Image Library button
        // - first checks if image library is available to be able to present button to user.
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            
            })
            // adds action to show "Photo Library" button in alert
            alertController.addAction(photoLibraryAction)
        }

        // Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // in larger screens (ipads), this indicates the pop-over alert which item sent the request
        // and presents the view over that sender
        alertController.popoverPresentationController?.sourceView = sender
        
        // presents alert
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Picks image from camera or image library and replaces the imageView image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
}


////////// Styling for buttons //////////
/*
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

@IBDesignable
class DesignableButton: UIButton {
}
*/




