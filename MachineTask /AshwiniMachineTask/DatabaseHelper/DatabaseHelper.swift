//
//  DatabaseHelper.swift
//  TODOTask
//


import Foundation
import CoreData
import UIKit
class DatabaseHelper {
    static var shareInstant = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    
    
    func  saveData(object:[String:String]) {
        let  venues = NSEntityDescription.insertNewObject(forEntityName: "Venues", into: context) as! Venues
        venues.id = object["id"]
        venues.name = object["name"]
        do
        {
            try context.save()
            print("data Save")
        }catch{
            print("data Not Save")
        }
    }
    
    func getVenueData() -> [Venues] {
        
        var venues = [Venues]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Venues")
        do{
            venues = try context.fetch(fetchRequest) as! [Venues]
            print("Data Fetch Successfully")
        } catch{
            print("Data Not Fetch Successfully")
        }
        return venues
    }
    
    func deleteData(index: Int) -> [Venues] {
        var todo = getVenueData()
        context.delete(todo[index])
        todo.remove(at:index)
        do{
            try  context.save()
            print("data deleted ")
        }
        catch{
            print("data not deleted ")
        }
        return todo
    }
    
    func editData(object:[String:String], index: Int)  {
        var venues = getVenueData()
        venues[index].id = object["id"]
        venues[index].name = object["name"]
       
        do
        {
            try context.save()
            print("data update Successfully")
        }catch
        {
            print("data is not save")
        }
    }
}

