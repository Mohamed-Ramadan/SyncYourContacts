//
//  ContactsListViewModel.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 26/09/2021.
//

import Foundation

class ContactsListViewModel {
    
    //MARK: - Variables
    private(set) var contactsUseCase: ContactsUseCase
    private(set) var contacts: [Contact] = [] {
        didSet {
            self.contactsCompletionHandler()
        }
    }
    
    var error:(_ errMsg: String)->() = {_ in}
    var contactsCompletionHandler: ()->() = {}
 
    //MARK: - init
    init(contactsUseCase: ContactsUseCase) {
        self.contactsUseCase = contactsUseCase
    }
    
    //MARK: - Class Methods
    func loadContacts() {
        contactsUseCase.fetchContacts { contacts in
            self.contacts = contacts.contacts
        } completion: { (result) in
            switch result {
                case .success(let model):
                    self.contacts = model.contacts
                case .failure(let error):
                    self.error(error.localizedDescription)
            }
        }
    }
}
