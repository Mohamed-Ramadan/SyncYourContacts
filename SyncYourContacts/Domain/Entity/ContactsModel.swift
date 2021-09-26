//
//  ContactsModel.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation

struct Contacts {
    let contacts: [Contact]
}

struct Contact {
    let identifier: String
    let name: String
    let emailAddresses: [String]
    let mobileNumbers: [String]
} 
