//
//  CoreDataStack.swift
//  CitiesOfCountry
//
//  Created by Taras Chernysh on 12/8/18.
//  Copyright © 2018 Taras Chernysh. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CitiesOfCountry")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
