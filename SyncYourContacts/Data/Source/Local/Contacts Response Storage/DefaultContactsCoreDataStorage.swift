//
//  DefaultContactsCoreDataStorage.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 25/09/2021.
//

import Foundation
import CoreData
 
final class DefaultContactsCoreDataStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    // MARK: - Private

    private func fetchRequest() -> NSFetchRequest<ContactsResponseEntity> {
        let request: NSFetchRequest = ContactsResponseEntity.fetchRequest()
        return request
    }

    private func deleteResponse(in context: NSManagedObjectContext) {
        let request = fetchRequest()

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension DefaultContactsCoreDataStorage: ContactsResponseStorage {

    func getResponse(completion: @escaping (Result<ContactsResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest()
                let responseEntity = try context.fetch(fetchRequest).first

                completion(.success(responseEntity?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response: ContactsResponseDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(in: context)

                _ = response.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
