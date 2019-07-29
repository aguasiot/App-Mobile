//
//  CDHandler.swift
//  Essbio
//
//  Created by Matias Villagran on 19-01-18.
//  Copyright © 2018 Matias Villagran. All rights reserved.
//

import UIKit
import CoreData

        class CDHandler:  NSObject {
            
            private class func getContext() -> NSManagedObjectContext {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                return appDelegate.persistentContainer.viewContext
                
                
            }
            class func saveObject(username:String, password:String) -> Bool {
                
                let context = getContext()
                let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
                let manageObject = NSManagedObject(entity: entity!, insertInto: context)
                
                manageObject.setValue(username, forKey: "username")
                manageObject.setValue(password, forKey: "password")
                
                do {
                    try context.save()
                    return true
                } catch{
                    
                    return false
                }
            }
            
            class func fetchObject() -> [Entity]? {
                
                let context = getContext()
                var user:[Entity]? = nil
                do{
                    
                    user = try context.fetch(Entity.fetchRequest())
                    return user
                    
                }catch{
                    return user
                }
                
            }    }

