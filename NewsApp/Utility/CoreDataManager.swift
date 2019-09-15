//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Harsha on 9/15/19.
//  Copyright © 2019 Harsha. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    private init() { }
    
    ///Getting the instance of AppDelegate
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    ///Global ManagedObjectContext
    
    var moc: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
}

extension CoreDataManager {
    
    ///Print SqLite DB URL:
    
    func printDBURL() {
        let dbUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("DB URL : \(dbUrls[dbUrls.count - 1])")
    }

    ///Get all entity of core data model
    
    func clearDatabase() {
        
        //Get all the entity names of the ManagedObjectModel
        
        guard let entities = appDelegate?.persistentContainer.managedObjectModel.entities.map({ $0.name }) else { return }
        
        for entity in entities {
            if let entityName = entity {
                self.handleDelete(ofEntity: entityName)
            }
        }
    }
    
    ///Clearing a particular table
    
    func clearData(ofEntity entity: CoreDataEntity) {
        
        self.handleDelete(ofEntity: entity.rawValue)
    }
    
    //Clear the Table with name
    func handleDelete(ofEntity entity: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc?.execute(deleteRequest)
            try moc?.save()
        } catch {
            print("Error Deleting objects of Entity \(entity)")
        }
    }
}
