//
//  ContactsService.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation


protocol ContactsService {
    func getContacts(completion:  @escaping (Result<ContactsResponseDTO, Error>) -> Void)
}

final class DefaultContactsService: ContactsService {
    func getContacts(completion: @escaping (Result<ContactsResponseDTO, Error>) -> Void) {
        //TODO: - Fetch user contacts here using Contacts framework
    }
}
