//
//  DBManager.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import UIKit
import CoreData

class DBManager {
    
   
    
    private var appDelegate:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func fetch(entityName: String) -> [NSManagedObject] {
        let managedContext = (appDelegate?.persistentContainer.viewContext)!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var items = [NSManagedObject]()
        do {
            items = try managedContext.fetch(fetchRequest)
            return items
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func insertToDatabase(dict: [String:Any], entityName: String, completion: ((_ success: Bool)->(Void)))
    {
        let managedContext = (appDelegate?.persistentContainer.viewContext)!
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValuesForKeys(dict)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
        completion(true)
    }
    
}
