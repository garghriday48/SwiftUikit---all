

import Foundation
import CoreData

protocol ContactsRepository{
    func create(contact: Contacts)
    func getAll() -> [Contacts]?
    func get(byIdentifier id: Int64) -> Contacts?
    func update(contact: Contacts) -> Bool
    func delete(record: Int64) -> Bool
}


struct ContactsData: ContactsRepository{
    func create(contact: Contacts) {
        let managedContext = PersistentStorage.shared.context
        
        let cdContacts = CDContacts(context: PersistentStorage.shared.context)
        cdContacts.firstName = contact.firstName
        cdContacts.secondName = contact.secondName
        cdContacts.phnNumber = contact.mobile
        cdContacts.id = contact.id
        if someEntityExists(id: Int(contact.id)){
            PersistentStorage.shared.saveContext()
        }
        
    }
    
    func getAll() -> [Contacts]? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
        var contacts: [Contacts] = []
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDContacts.fetchRequest()) as? [CDContacts] else {return nil}
            
            
            result.forEach { cdContact in
                let myContact = Contacts(firstName: cdContact.firstName ?? "", secondName: cdContact.secondName ?? "", mobile: cdContact.phnNumber ?? [""], id: cdContact.id)
                contacts.append(myContact)
            }
        } catch let error {
            debugPrint(error)
        }
        return contacts
    }
    func get(byIdentifier id: Int64) -> Contacts? {
        
        let result = getContact(byIdentifier: id)
        guard result != nil else {return nil}
        let myEmployee = Contacts(firstName: result!.firstName ?? "", secondName: result!.secondName ?? "", mobile: result!.phnNumber ?? [""], id: result!.id)
        return myEmployee
    }
    
    func update(contact: Contacts) -> Bool {
        let record = getContact(byIdentifier: contact.id)
        guard record != nil else{ return false }
        record?.firstName = contact.firstName
        record?.secondName = contact.secondName
        record?.phnNumber = contact.mobile
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(record: Int64) -> Bool {
        //let cont = Contacts()
        let field = getContact(byIdentifier: record)
        guard field != nil else{ return false }
        
        PersistentStorage.shared.context.delete(field!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    //    private func getContact(byIdentifier name: String) -> CDContacts?{
    //        let request = NSFetchRequest<CDContacts>(entityName: "CDContacts")
    //        let predicate = NSPredicate(format: "firstName == %@",name as! CVarArg)
    //        request.predicate = predicate
    //        do {
    //            let result = try PersistentStorage.shared.context.fetch(request).first
    //            guard result != nil else {return nil}
    //            return result
    //
    //        } catch let error {
    //            debugPrint(error)
    //        }
    //        return nil
    //    }
    private func getContact(byIdentifier id: Int64) -> CDContacts?{
        let request = NSFetchRequest<CDContacts>(entityName: "CDContacts")
        let predicate = NSPredicate(format: "id == %d",id)
        request.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(request).first
            guard result != nil else {return nil}
            return result
            
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    private func someEntityExists(id: Int) -> Bool {
        let managedContext = PersistentStorage.shared.context
        let fetchRequest = NSFetchRequest<CDContacts>(entityName: "CDContacts")
        //fetchRequest.includesSubentities = false
        
        //fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count <= 1 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
            ////            }
            //        var entitiesCount = 0
            //
            //        do {
            //            entitiesCount = try managedObjectContext.count(for: fetchRequest)
            //        }
            //        catch {
            //            print("error executing fetch request: \(error)")
            //        }
            //
            //        return entitiesCount == 0
        }
        
    }
}
