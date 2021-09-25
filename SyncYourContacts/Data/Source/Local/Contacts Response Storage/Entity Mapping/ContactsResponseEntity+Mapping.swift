//
//  ContactsResponseEntity+Mapping.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation
import CoreData

//MARK: Mapping To Data Transfer Object
extension ContactsResponseEntity {
    func toDTO() -> ContactsResponseDTO {
        .init(contacts: contacts?.map{ ($0 as! ContactResponseEntity).toDTO()} ?? [])
    }
}

extension ContactResponseEntity {
    func toDTO() -> ContactDTO {
        return .init(identifier: identifier ?? "",
                     name: name ?? "",
                     email: email ?? "",
                     mobileNumbers: phoneNumbers?.map{ ($0 as! PhoneNumberResponseEntity).toDTO()} ?? [])
    }
}

extension PhoneNumberResponseEntity {
    func toDTO() -> MobileNumberDTO {
        return .init(number: number ?? "")
    }
}


//MARK: Mapping To Entity
extension ContactsResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> ContactsResponseEntity {
        let entity: ContactsResponseEntity = .init(context: context)
        contacts.forEach {
            entity.addToContacts($0.toEntity(in: context))
        }
        return entity
    }
}

extension ContactDTO {
    func toEntity(in context: NSManagedObjectContext) -> ContactResponseEntity{
        let entity: ContactResponseEntity = .init(context: context)
        entity.name = name
        entity.identifier = identifier
        entity.email = email
        mobileNumbers.forEach {
            entity.addToPhoneNumbers($0.toEntity(in: context))
        }
        return entity
    }
}

extension MobileNumberDTO {
    func toEntity(in context: NSManagedObjectContext) -> PhoneNumberResponseEntity {
        let entity: PhoneNumberResponseEntity = .init(context: context)
        entity.number = number
        return entity
    }
}
