//
//  ThirdViewController.swift
//  coreData
//
//  Created by Pragath on 10/03/23.
//

import UIKit

class ThirdViewController: UIViewController {

    
    @IBOutlet weak var updateNameTxtField: UITextField!
    
    @IBOutlet weak var updateEmailTxtField: UITextField!
    
    private let emp: EmployeeData = EmployeeData()
    var selectedEmployee: ModelEmployee? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateNameTxtField.text = selectedEmployee?.name
        updateEmailTxtField.text = selectedEmployee?.email
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func updateButton(_ sender: Any) {
        
        let employee = ModelEmployee(email: updateEmailTxtField.text, id: selectedEmployee!.id, name: updateNameTxtField.text)
        if(emp.update(employee: employee)){
            diplayAlert(message: "getting updated")
        }else{
            diplayErrorAlert()
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        if(emp.delete(record: selectedEmployee!.id)){
            diplayAlert(message: "getting deleted")
        }else{
            diplayErrorAlert()
        }
        
        
    }
    
    private func diplayAlert(message: String){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){(action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
    }
    
    private func diplayErrorAlert(){
        
        let alert = UIAlertController(title: "Alert", message: "Something wrong happened", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){(action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
