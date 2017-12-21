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
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if nameAddTextfield.text == "" {
            let alert = UIAlertController(title: "Manjka ime in priimek!", message: "Brez imena in priimka ne morem shraniti vizitke!", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Ime in priimek"
            }
            
            let action = UIAlertAction(title: "Dodaj.", style: .default){ (_) in
                self.nameAddTextfield.text = alert.textFields?.first?.text ?? ""
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        if nameAddTextfield.text != "" {
            let name = nameAddTextfield.text
            let company = companyAddTextfield.text
            let email = emailAddTextfield.text
            let phone = phoneAddTextfield.text
            var pictureIsOnLeft = true
            if pictureLocationChooserSegmentedControl.selectedSegmentIndex == 1 {
                pictureIsOnLeft = false
            }
            
            contacts?.append(Contact(name: name!, company: company, email: email, phone: phone, pictureIsOnLeft: pictureIsOnLeft, image: myImageView.image!)!)
            
            saveContacts(contacts: contacts!)
            
            // go back to ViewController
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    


}
