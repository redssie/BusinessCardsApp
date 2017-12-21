//
//  Contact.swift
//  test
//
//  Created by Maja Zafran on 20/12/2017.
//  Copyright © 2017 Maja Zafran. All rights reserved.
//

import Foundation
import UIKit

class Contact: NSObject, NSCoding {
    
    //properties
    var name: String
    var company: String?
    var email: String?
    var phone: String?
    var pictureIsOnLeft: Bool
    var image: UIImage?
    
    
    //file path to data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("savedContacts")
    
    
    //types
    struct PropertyKey {
        static let name  = "name"
        static let company = "company"
        static let email = "email"
        static let phone = "phone"
        static let pictureIsOnLeft = "pictureIsOnLeft"
        static let image = "image"
    }
    
    //init
    init? (name: String, company: String?, email: String?, phone: String?, pictureIsOnLeft: Bool, image: UIImage?) {
        guard !name.isEmpty else { return nil }
        
        self.name = name
        self.company = company
        self.email = email
        self.phone = phone
        self.pictureIsOnLeft = pictureIsOnLeft
        self.image = image
    }
    
    //NSCoder
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(company, forKey: PropertyKey.company)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(phone, forKey: PropertyKey.phone)
        aCoder.encode(pictureIsOnLeft, forKey: PropertyKey.pictureIsOnLeft)
        aCoder.encode(image, forKey: PropertyKey.image)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //name is required
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Contact object.")
            return nil
        }
        //let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let company = aDecoder.decodeObject(forKey: PropertyKey.company) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let phone = aDecoder.decodeObject(forKey: PropertyKey.phone) as? String
        let pictureIsOnLeft = aDecoder.decodeBool(forKey: PropertyKey.pictureIsOnLeft)
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        self.init(name: name, company: company, email: email, phone: phone, pictureIsOnLeft: pictureIsOnLeft, image: image)
    }
    
    
    
    
    
    
    
    
    
}
