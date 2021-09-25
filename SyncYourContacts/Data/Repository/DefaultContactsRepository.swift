//
//  DefaultContactsRepository.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation


final class DefaultContactsRepository {
   private let contactsCache: ContactsResponseStorage
    private let contactsService: ContactsService
    
    init(contactsCache: ContactsResponseStorage, contactsService: ContactsService ) {
       self.contactsCache = contactsCache
        self.contactsService = contactsService
   }
}

extension DefaultContactsRepository: ContactsRepository {
    func getContacts(cached: @escaping (Contacts) -> Void,
                     completion: @escaping (Result<ContactsResponseDTO, Error>) -> Void) {
        
        contactsCache.getResponse { result in
            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
        }
        
        contactsService.getContacts  { (result) in
            switch result {
            case .success(let model):
                self.contactsCache.save(response: model)
                
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
