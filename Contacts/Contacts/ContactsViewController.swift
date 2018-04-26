//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Olivia Bishop on 4/26/18.
//  Copyright © 2018 Olivia Bishop. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet var ContactsTableView: UITableView!
    
    var contacts = [Contact]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do{
             contacts = try managedContext.fetch(fetchRequest)
            
            ContactsTableView.reloadData()
            
        } catch {
            
            print("Fetch Could Not Be Performed")
        }
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddNewContact(_ sender: Any) {
        
        performSegue(withIdentifier: "ShowContact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleContactViewController,
            let selectedRow = self.ContactsTableView.indexPathForSelectedRow?.row else{
                
                return
        }
        
        destination.existingContact = contacts[selectedRow]
    }
    
    
    func deleteContact(at indexPath: IndexPath){
        
        let contact = contacts[indexPath.row]
        
        if let managedContext = contact.managedObjectContext {
            
            managedContext.delete(contact)
            
            do {
                
               try managedContext.save()
                
                self.contacts.remove(at: indexPath.row)
                
                ContactsTableView.deleteRows(at: [indexPath], with: .automatic)
                
                
            
            } catch{
                
                print("Contact could not be deleted")
                
                
                ContactsTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        
            
        }
    }
    
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            deleteContact(at: indexPath)
        }
    }
    
    
    
}

extension ContactsViewController: UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContact", sender: self)
    }
}
  
    
    
    

