//
//  SingleContactViewController.swift
//  Contacts
//
//  Created by Olivia Bishop on 4/26/18.
//  Copyright © 2018 Olivia Bishop. All rights reserved.
//

import UIKit

class SingleContactViewController: UIViewController {

    
    @IBOutlet var NameTextField: UITextField!
    
    @IBOutlet var NumberTextField: UITextField!
    
    var existingContact: Contact?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NameTextField.delegate = self
        NumberTextField.delegate = self
        
        
        NameTextField.text = existingContact?.name
        NumberTextField.text = existingContact?.number
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func SaveContact(_ sender: Any) {
        
        let name = NameTextField.text
        let number = NumberTextField.text
        
        var contact: Contact?
        
        if let existingContact = existingContact{
            
            existingContact.name = name
            existingContact.number = number
            
            
            contact = existingContact
            
        } else{
            
            contact = Contact(name: name, number: number)
        }
        
        
        
        if let contact = contact {
            
            do{
                let managedContext = contact.managedObjectContext
                
               try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
                
                
            } catch{
                print("Contact could not be saved")
            }
        }
        
        
    }
    
}


extension SingleContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
        
    }
}



