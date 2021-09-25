//
//  ContactsResponseDTO+Mapping.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation


// MARK: - Data Transfer Object
struct ContactsResponseDTO {
    let contacts: [ContactDTO]
}

struct ContactDTO {
    let identifier: String
    let name: String
    let email: String
    let mobileNumbers: [MobileNumberDTO]
}

struct MobileNumberDTO {
    let number: String  
}

//MARK: Mapping To Domain
extension ContactsResponseDTO {
    func toDomain() -> Contacts {
        return .init(contacts: contacts.map{ $0.toDomain()})
    }
}

extension ContactDTO {
    func toDomain() -> Contact {
        return .init(identifier: identifier, name: name, email: email, mobileNumbers: mobileNumbers.map{$0.toDomain()})
    }
}

extension MobileNumberDTO {
    func toDomain() -> MobileNumber {
        return .init(number: number)
    }
}
