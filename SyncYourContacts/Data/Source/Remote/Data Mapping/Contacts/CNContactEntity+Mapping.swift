//
//  CNContactEntity+Mapping.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 26/09/2021.
//

import Foundation
import Contacts

extension CNContact {
    func toDTO() -> ContactDTO {
        return .init(identifier: identifier,
                     name: "\(givenName) \(familyName)",
                     emailAddresses: emailAddresses.map{$0.toDTO()},
                     mobileNumbers: phoneNumbers.map{ $0.toDTO()})
        
    }
}

extension CNLabeledValue where ValueType == CNPhoneNumber {
    func toDTO() -> MobileNumberDTO {
        return .init(number: value.stringValue)
    }
}

extension CNLabeledValue where ValueType == NSString {
    func toDTO() -> EmailDTO {
        return .init(email: value.description)
    }
}
