//
//  EmployeeRepository.swift
//  coreData
//
//  Created by Pragath on 10/03/23.
//

import Foundation
import CoreData

protocol EmployeeRepository{
    func create(employee: ModelEmployee)
    func getAll() -> [ModelEmployee]?
    func get(byIdentifier id: UUID) -> ModelEmployee?
    func update(employee: ModelEmployee) -> Bool
    func delete(record: UUID) -> Bool
}


struct EmployeeData: EmployeeRepository{
    
    func create(employee: ModelEmployee) {
        let myEmployee = Employee(context: PersistentStorage.shared.context)
        myEmployee.name = employee.name
        myEmployee.id = employee.id
        myEmployee.email = employee.email
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [ModelEmployee]? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
        var employees: [ModelEmployee] = []
        do {
            guard let result = try PersistentStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {return nil}
            
            
            result.forEach { cdEmployee in
                let myEmployee = ModelEmployee(email: cdEmployee.email, id: cdEmployee.id, name: cdEmployee.name)
                employees.append(myEmployee)
            }
        } catch let error {
            debugPrint(error)
        }
        return employees
        
    }
    
    func get(byIdentifier id: UUID) -> ModelEmployee? {
        
        let result = getEmployeeID(byIdentifier: id)
        guard result != nil else {return nil}
        let myEmployee = ModelEmployee(email: result!.email, id: result!.id, name: result!.name)
        return myEmployee
    }
    
    private func getEmployeeID(byIdentifier id: UUID) -> Employee?{
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
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
    
    
    func update(employee: ModelEmployee) -> Bool{
        let record = getEmployeeID(byIdentifier: employee.id)
        guard record != nil else{ return false }
        record?.name = employee.name
        record?.id = employee.id
        record?.email = employee.email
        
        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(record: UUID) -> Bool{
        let field = getEmployeeID(byIdentifier: record)
        guard field != nil else{ return false }
        
        PersistentStorage.shared.context.delete(field!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
}
