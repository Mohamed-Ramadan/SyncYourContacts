//
//  ContactsUseCase.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation

protocol ContactsUseCase {
      
    func fetchContacts(cached: @escaping (Contacts) -> Void,
                       completion: @escaping (Result<Contacts, Error>) -> Void)
}

final class DefaultContactsUseCase: ContactsUseCase {
   
    private let contactsRepository: ContactsRepository
    
    //MARK: - Init
    init(contactsRepository: ContactsRepository) {
        self.contactsRepository = contactsRepository
    }
   
    //MARK: - Clients
    func fetchContacts(cached: @escaping (Contacts) -> Void,
                       completion: @escaping (Result<Contacts, Error>) -> Void) {
        
        return contactsRepository.getContacts(cached: cached) { (result) in
            switch result {
                case .success(let model):
                    completion(.success(model.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
            }
         }
    }
}
