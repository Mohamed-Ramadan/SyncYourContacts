//
//  ContactsResponseStorage.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation

protocol ContactsResponseStorage {
    func getResponse(completion: @escaping (Result<ContactsResponseDTO?, CoreDataStorageError>) -> Void)

    func save(response: ContactsResponseDTO)
}
