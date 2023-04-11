//
//  ModelEmployee.swift
//  coreData
//
//  Created by Pragath on 10/03/23.
//

import Foundation

struct ModelEmployee{
    
    var email: String?
    var id: UUID
    var name: String?
    
    init(email: String?, id: UUID, name: String?) {
        self.email = email
        self.id = id
        self.name = name
    }
    
}
