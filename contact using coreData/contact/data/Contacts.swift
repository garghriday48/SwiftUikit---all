import Foundation

class Contacts {
    
    // MARK: properties
    var firstName: String
    var secondName: String
    var mobile: [String]
    var id: Int64
    
    
    // MARK: initializers
    init(firstName: String, secondName:String, mobile: [String], id: Int64) {
        self.firstName = firstName
        self.secondName = secondName
        self.mobile = mobile
        self.id = id
    }
//    init(firstName: String, secondName:String, mobile: [String]){
//        self.firstName = firstName
//        self.secondName = secondName
//        self.mobile = mobile
//    }
    
    //MARK: Method to get full name
    func getFullName() -> String {
        if self.firstName != "" && self.secondName != ""{
            return self.firstName + " " + self.secondName
            
        }
        else if self.firstName != "" {
            return firstName
        }
        else if self.secondName != "" {
            return secondName
        }
        return ""
    }
    
}
