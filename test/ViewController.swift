//
//  ViewController.swift
//  test
//
//  Created by Maja Zafran on 20/12/2017.
//  Copyright © 2017 Maja Zafran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    @IBAction func AddContactButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addContactSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetail" || segue.identifier == "ShowDetailVertical"), let destination = segue.destination as? AddContactViewController, let index = tableView.indexPathForSelectedRow?.row {
            print("index at path row: \(index)")
            destination.contact = contacts[index]
            destination.rowToSwitch = index
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }


    //no. of rows in section
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !contacts.isEmpty else { return 1}
        return contacts.count
    }
    
    //height of a row
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !contacts.isEmpty else { return 250}
        if contacts[indexPath.row].pictureIsOnLeft {
                return 150
            }
        return 200
    }
    
    
    
    //cell for each row
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !contacts.isEmpty else {
            return tableView.dequeueReusableCell(withIdentifier: "addContactCell")!
        }
        let contact = contacts[indexPath.row]
        //set verticalCustomCell (picture is on top and data underneath)
        if !contact.pictureIsOnLeft {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "verticalCustomCell") as! VerticalCustomTableViewCell
            cell.verticalCellView.layer.cornerRadius = cell.verticalCellView.frame.height / 6
            
            cell.verticalNameLabel.text = contact.name
            cell.verticalCompanyLabel.text = contact.company
            cell.verticalEmailLabel.text = contact.email
            cell.verticalPhoneLabel.text = contact.phone
            
            
            cell.imageIsOnTop.image = contact.image
            cell.imageIsOnTop.layer.cornerRadius = cell.imageIsOnTop.frame.width / 2
            
            return cell
        } else {
            //set customCell (picture is on left and data in right)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
            cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 6
            
            
            cell.nameLabel.text = contact.name
            cell.companyLabel.text = contact.company
            cell.emailLabel.text = contact.email
            cell.phoneLabel.text = contact.phone
            
            cell.imageIsOnLeft.image = contact.image
            cell.imageIsOnLeft.layer.cornerRadius = cell.imageIsOnLeft.frame.height / 2
            
            return cell
        }
        
    }
    
    //allows conditional editing
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard !contacts.isEmpty else { return false}
        return true
    }
    
    //delete row in tableview
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard !contacts.isEmpty else { return }
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            saveContacts(contacts: contacts)
            tableView.reloadData()
        }
    }

    private func loadSampleContact(){
        let image = UIImage(named: "noImage.jpeg")
        //guard let horizontalContact = Contact(name: "Ime Priimek", company: "Podjetje in pozicija", email: "ime@podjetje.si", phone: "051 123 456", pictureIsOnLeft: true, image: image) else { fatalError("Error loadSampleContact: horizontalContact")}
        guard let verticalContact = Contact(name: "Ime Priimek", company: "Podjetje in pozicija", email: "ime.priimek@podjetje.si", phone: "051 123 456", pictureIsOnLeft: false, image: image) else { fatalError("Error loadSampleContact: verticalContact")}
        
        //contacts?.append(horizontalContact)
        contacts.append(verticalContact)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

