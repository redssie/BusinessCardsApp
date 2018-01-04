//
//  AddContactViewController.swift
//  test
//
//  Created by Maja Zafran on 20/12/2017.
//  Copyright © 2017 Maja Zafran. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    //properties
    @IBOutlet weak var nameAddTextfield: UITextField!
    @IBOutlet weak var companyAddTextfield: UITextField!
    @IBOutlet weak var emailAddTextfield: UITextField!
    @IBOutlet weak var phoneAddTextfield: UITextField!
    @IBOutlet weak var pictureLocationChooserSegmentedControl: UISegmentedControl!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var addContactButton: UIButton!
    
    @IBAction func nameChanged(_ sender: UITextField) {
        guard let text = sender.text, validateName(for: text) else {
            sender.layer.borderColor = UIColor.red.cgColor
            sender.layer.borderWidth = 1.0
            return
        }
        sender.layer.borderWidth = 0.0
        
        validateInfo()
    }
    
    @IBAction func emailChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if !validateEmail(for: text) {
            sender.layer.borderColor = UIColor.red.cgColor
            sender.layer.borderWidth = 1.0
        } else {
            sender.layer.borderWidth = 0.0
        }
        
        validateInfo()
    }
    
    @IBAction func phoneNumberChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if !validatePhoneNumber(for: text) {
            sender.layer.borderColor = UIColor.red.cgColor
            sender.layer.borderWidth = 1.0
        } else {
            sender.layer.borderWidth = 0.0
        }
        
        validateInfo()
    }
    
    
    
    var contact: Contact?
    var rowToSwitch: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        nameAddTextfield.delegate = self
        nameAddTextfield.tag = 0
        
        guard let setData = contact else {return}
        nameAddTextfield.text = setData.name
        companyAddTextfield.text = setData.company
        emailAddTextfield.text = setData.email
        phoneAddTextfield.text = setData.phone
        myImageView.image = setData.image
        if setData.pictureIsOnLeft {
            pictureLocationChooserSegmentedControl.selectedSegmentIndex = 0
        } else {
            pictureLocationChooserSegmentedControl.selectedSegmentIndex = 1
        }
        
        
    }
    
    //go to next textfield when return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    
    //adds picture
    @IBAction func addPicture(_ sender: UIButton) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            image.sourceType = UIImagePickerControllerSourceType.camera
        }
        
        
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            //after it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //try to convert it into image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
        }
        else {
            //display Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addContact(_ sender: UIButton) {
        if nameAddTextfield.text != "" {
            let name = nameAddTextfield.text
            let company = companyAddTextfield.text
            let email = emailAddTextfield.text
            let phone = phoneAddTextfield.text
            var pictureIsOnLeft = true
            var image = myImageView.image
            if pictureLocationChooserSegmentedControl.selectedSegmentIndex == 1 {
                pictureIsOnLeft = false
            }
            
            if (image == UIImage(named: "noImage.jpeg")) {
                let randomImage = ["girl", "guy", "panda", "noImage"]
                let random = Int(arc4random_uniform(4))
                image = UIImage(named: randomImage[random])
            }
            let contactToAdd = Contact(name: name!, company: company, email: email, phone: phone, pictureIsOnLeft: pictureIsOnLeft, image: image!)!
            
            if contact != nil, rowToSwitch != nil {
                contacts[rowToSwitch!] = contactToAdd
            } else {
                contacts.append(contactToAdd)
            }
            
            
            
            saveContacts(contacts: contacts)
            
            // go back to ViewController
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
}

extension AddContactViewController {
    
    func validateName(for text: String) -> Bool {
        return text.count > 0
        
    }
    
    func validateEmail(for text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: text)
    }
    
    func validatePhoneNumber(for text: String) -> Bool {
        let phoneRegEx = "[0-9\\+\\#]{7,14}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: text)
    }
    
    func validateInfo() {
        if let name = nameAddTextfield.text, !validateName(for: name) {
            addContactButton.isEnabled = false
            addContactButton.alpha = 0.3
            
            return
        }
        if let email = emailAddTextfield.text, validateEmail(for: email) {
            addContactButton.isEnabled = true
            addContactButton.alpha = 1.0
            return
        }
        else if let phoneNumber = phoneAddTextfield.text, validatePhoneNumber(for: phoneNumber) {
            addContactButton.isEnabled = true
            addContactButton.alpha = 1.0
            return
        }
        addContactButton.isEnabled = false
        addContactButton.alpha = 0.3
    }
    
    
    
    
}




