//
//  AddViewController.swift
//  contact
//
//  Created by Hriday on 02/03/23.
//

import UIKit

struct TextFieldModel {
    var firstTextFieldData: String
    var secondTextFieldData: String
    var phnTextField: [String]
    
    init(textData1: String, textData2: String, textData3: [String]) {
        firstTextFieldData  = textData1
        secondTextFieldData = textData2
        phnTextField = textData3
    }
}

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var numberTableView: UITableView!
    
    @IBOutlet weak var backToFirst: UIBarButtonItem!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //var addContactDelegate: addContact?
    
    var dataModel = [TextFieldModel]()
    
    var labelForNum = ["Home", "Work", "Extra"]

    var numberCells: [NumberTableViewCell2?] = [nil]
    var numOfCells = 1
    
    
    var fNameFromTextField: UITextField?
    var sNameFromTextField: UITextField?
    
    var dataInstance = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<2 { dataModel.append(TextFieldModel(textData1: "", textData2: "", textData3: [""])) }
        
        registerCells()
        photo.layer.cornerRadius = 100
        
    
        numberTableView.layoutIfNeeded()
        numberTableView.isEditing = true
        numberTableView.allowsSelectionDuringEditing = true
    }
    
    func registerCells(){
        addTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        
    }
    
    @objc func backToController(){
        dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        numberTableView.heightAnchor.constraint(equalToConstant:CGFloat(160)).isActive = true
    }
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    var mainIndex = NSIndexPath()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        let firstVC = segue.destination as! ViewController
        let firstName = dataModel[0].firstTextFieldData.capitalized
        let secondName = dataModel[0].secondTextFieldData.capitalized
        var newArray: [String] = []
        for val in dataModel[0].phnTextField{
            if val != ""{
                newArray.append(val)
            }
        }
        let phnNumber = newArray
        //var phnNumber = dataModel[0].phnTextField
        let newContact  = Contacts(firstName: firstName, secondName: secondName, mobile: phnNumber, id: Int64(dataInstance.idCount + 1))
        firstVC.contactArray.append(newContact)
        firstVC.makeDict(in: firstVC.contactArray)
        firstVC.myTable.reloadData()
    }
    

}
extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var num = 0
        if tableView == addTableView{ num = 1 }
        else if tableView == numberTableView{ num = 1 }
        
        return num
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if tableView == addTableView{ num = 2 }
        else{
            return numOfCells
        }
        return num
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addTableView{

            switch indexPath.row{
            case 0:
                let cell = addTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
                cell.nameTextField.placeholder = "Enter First Name"
                cell.nameTextField.delegate = self
                cell.nameTextField.tag = indexPath.row
                cell.nameTextField.text = dataModel[indexPath.row].firstTextFieldData
                return cell
            case 1:
                let cell = addTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
                cell.nameTextField.placeholder = "Enter Second Name"
                cell.nameTextField.delegate = self
                cell.nameTextField.tag = indexPath.row
                cell.nameTextField.text = dataModel[indexPath.row].secondTextFieldData
                return cell
            default:
                return UITableViewCell()
            }
        }

        else if tableView == numberTableView{
            if numOfCells - 1 == indexPath.row {
                let cell = numberTableView.dequeueReusableCell(withIdentifier: "addNumber", for: indexPath) as! NumberTableViewCell1
                cell.phoneLabel.text = "Add phone"
                return cell
            }
            else{
                let secondCell = numberTableView.dequeueReusableCell(withIdentifier: "infoNumber", for: indexPath) as! NumberTableViewCell2
                secondCell.typeOfNum.text = labelForNum[indexPath.row]
                secondCell.numberTextField.placeholder = "Enter Number"
                secondCell.numberTextField.delegate = self
                secondCell.numberTextField.tag = indexPath.row + 2
                
                return secondCell
                
            }
        }
        return UITableViewCell()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            let index = NSIndexPath(row: textField.tag,section : 0)
            mainIndex = index
            if index.row == 0{
                dataModel[0].firstTextFieldData = textField.text ?? ""
            }
            else if index.row == 1{
                dataModel[0].secondTextFieldData = textField.text ?? ""
                //dataModel[1].phnTextField! = textField.text!
            }
            else if textField.tag >= 2{
                dataModel[0].phnTextField[textField.tag - 2] = (textField.text ?? "")
            }
        }
        
        
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if numOfCells - 1 == indexPath.row {
            if dataModel[0].phnTextField.count < 4{
                //navigationItem.rightBarButtonItem?.isEnabled = true
                dataModel[0].phnTextField.append("")
                numOfCells += 1
            }
            else if dataModel[0].phnTextField.count == 4{
                let action = UIAlertController(title: "Phone Numbers", message: "Can have 3 phone numbers", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default)
                action.addAction(okAction)
                self.present(action, animated: true)
            }
            
            
            numberTableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if numOfCells - 1 == indexPath.row {
            return .insert
            
        }
        else{
            return .delete
        }
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            if dataModel[0].phnTextField.count < 4{
                dataModel[0].phnTextField.append("")
                //navigationItem.rightBarButtonItem?.isEnabled = true
                numOfCells += 1
            }
            else if dataModel[0].phnTextField.count == 4{
                let action = UIAlertController(title: "Phone Numbers", message: "Can have 3 phone numbers", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default)
                action.addAction(okAction)
                self.present(action, animated: true)
            }
//            else if dataModel[0].phnTextField == !{
//                navigationItem.rightBarButtonItem?.isEnabled = false
//            }
            

            numberTableView.reloadData()
        }
        else if editingStyle == .delete{
            self.view.endEditing(true)
            //navigationItem.rightBarButtonItem?.isEnabled = true
            numOfCells -= 1
            dataModel[0].phnTextField.remove(at: indexPath.row)
            numberTableView.reloadData()
            
//            if dataModel[0].phnTextField == !{
//                navigationItem.rightBarButtonItem?.isEnabled = false
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == addTableView{
            return 50
        }
        else if tableView == numberTableView{
            //UITableView.automaticDimension
            return 40
            
        }
        return CGFloat()
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 2{
//            return 10
//        }
//        else{
//            return 10
//        }
//    }
}
