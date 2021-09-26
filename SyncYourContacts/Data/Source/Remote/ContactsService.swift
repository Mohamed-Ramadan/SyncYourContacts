//
//  ContactsService.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation
import Contacts


protocol ContactsService {
    func getContacts(completion:  @escaping (Result<ContactsResponseDTO, Error>) -> Void)
}

final class DefaultContactsService: ContactsService {
    func getContacts(completion: @escaping (Result<ContactsResponseDTO, Error>) -> Void) {
        // Fetch user contacts here using Contacts framework
        var contacts = [ContactDTO]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                    CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey,
                    CNContactThumbnailImageDataKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact.toDTO())
            }
            
            completion(.success(.init(contacts: contacts)))
        }
        catch let error {
            print("unable to fetch contacts: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
