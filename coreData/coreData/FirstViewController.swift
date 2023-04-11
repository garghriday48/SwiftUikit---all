//
//  ViewController.swift
//  coreData
//
//  Created by Pragath on 09/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    private let emp: EmployeeData = EmployeeData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createButton(_ sender: Any) {
        
        let employee = ModelEmployee(email: emailTextField.text, id: UUID(), name: nameTextField.text)
        emp.create(employee: employee)
        
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
        //self.performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
}

