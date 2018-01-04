//
//  Constants.swift
//  test
//
//  Created by Maja Zafran on 21/12/2017.
//  Copyright © 2017 Maja Zafran. All rights reserved.
//

import Foundation

var contacts:[Contact] = []

func saveContacts(contacts: [Contact]){
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
    print(Contact.ArchiveURL.path)
    if isSuccessfulSave {
        print("Contact saved")
    } else {
        print("Failed to save a contact")
    }
}



func loadContacts() -> [Contact] {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact] ?? [Contact]()
}
