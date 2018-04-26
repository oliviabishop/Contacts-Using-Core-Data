//
//  Contact+CoreDataClass.swift
//  Contacts
//
//  Created by Olivia Bishop on 4/26/18.
//  Copyright © 2018 Olivia Bishop. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    
  
    convenience init?(name: String?, number: String?) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
       self.init(entity: Contact.entity(), insertInto: managedContext)
        
        self.name = name
        self.number = number
        
        
        
    }
    

}
