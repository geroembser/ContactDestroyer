//
//  ViewController.swift
//  ContactDestroyer🛳
//
//  Created by Gero Embser on 25.04.18.
//  Copyright © 2018 Gero Embser. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    private func showAlert(with title: String?, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteAllContacts() {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, _) in
            guard granted else {
                DispatchQueue.main.async {
                    self.showAlert(with: "Contact access required!", andMessage: "Please go to settings and turn on contact access. Then try again!")
                }
                
                return
            }
            //fetch all containers
            guard let allContainers = try? store.containers(matching: nil) else {
                return
            }
            
            for containerIdentifier in (allContainers.map { $0.identifier }) {
                let predicates = CNContact.predicateForContactsInContainer(withIdentifier: containerIdentifier)
                
                guard let contacts = try? store.unifiedContacts(matching: predicates, keysToFetch: [CNContactPhoneNumbersKey as CNKeyDescriptor]) else {
                    return
                }
                
                let saveRequest = CNSaveRequest()
                
                contacts.forEach { saveRequest.delete($0.asMutableContact()) }
                
                //delete! 🎉
                do {
                    try store.execute(saveRequest)
                    NSLog("Deleting was successful...")
                    
                    self.showAlert(with: "🎉", andMessage: "All contacts are hopelessly lost forever...")
                }
                catch {
                    NSLog("Deleting wasn't successful...")
                    
                    self.showAlert(with: "😢", andMessage: "Something went wrong...")
                }
            }
        }
    }
    
}

