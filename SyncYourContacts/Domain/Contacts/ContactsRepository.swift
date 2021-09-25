//
//  ContactsRepository.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation


protocol ContactsRepository { 
    func getContacts(
        cached: @escaping (Contacts) -> Void,
        completion: @escaping (Result<ContactsResponseDTO, Error>) -> Void)
}
