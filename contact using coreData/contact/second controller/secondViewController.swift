

import UIKit

protocol doneButton{
    func comingBack(fname: String, sname: String, phnNum: [String])
}

class secondViewController: UIViewController, doneButton {
    
    
//MARK: PROPERTIES
    
    @IBOutlet var contactName: UILabel!
    
    @IBOutlet weak var messageBox: UIView!
    @IBOutlet weak var phoneBox: UIView!
    @IBOutlet weak var mailBox: UIView!
    
    
    @IBOutlet weak var phoneTableView: UITableView!
    
    var coName: (String?,[String])?
    var indexp: (IndexPath,ViewController)?
    var text: UITextField?
    
    var aNameText: UITextField?
    var aMobileText: UITextField?
    
    var labelArray = ["home", "work", "extra"]
    
    var fName: String?
    var sName: String?
    
    
//MARK: METHODS
    override func viewWillAppear(_ animated: Bool) {
        phoneTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteContact)),
            UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editContact)),
            
        ]
        contactName.text = String((fName ?? " ") + " " + (sName ?? " "))
        
        
        messageBox.layer.cornerRadius = 10
        phoneBox.layer.cornerRadius = 10
        mailBox.layer.cornerRadius = 10
        
        phoneTableView.layer.cornerRadius = 10
        
    }
    override func viewDidLayoutSubviews() {
        phoneTableView.heightAnchor.constraint(equalToConstant:CGFloat((3)*60)).isActive = true
    }
    
    //MARK: To delete contact
    @objc func deleteContact(){
        
        let index = indexp!.0
        let firstVC = indexp!.1
        let alert2 = UIAlertController(title: "Delete", message: "Are you Sure?", preferredStyle: .alert)
        
        let remove = UIAlertAction(title: "Remove", style: .default){ (deleteAction) in
            
            firstVC.contactDict[firstVC.sectionTitle[index.section]]?.remove(at: index.row)
        
            firstVC.myTable.deleteRows(at: [index], with: .fade)
            if firstVC.contactDict[firstVC.sectionTitle[index.section]]?.count == 0{
                firstVC.sectionTitle.remove(at: index.section)
            }
            
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel){(deleteAction) in
            print("ended")
            print(index[0],index[1])
            
            
        }
        alert2.addAction(remove)
        alert2.addAction(cancel)
        
        self.present(alert2, animated: true, completion: nil)
        
    }
    
    //MARK: Method of doneButton protocol to get edited data and display it on second view controller and send it to first view controller
    func comingBack(fname: String, sname: String, phnNum: [String]){
        let index = indexp!.0
        let firstVC = indexp!.1
        contactName.text = String(fname + " " + sname)
        
        coName?.1 = phnNum
        var deleteContact = firstVC.contactDict[firstVC.sectionTitle[index.section]]?.remove(at: index.row)
        
        if firstVC.contactDict[firstVC.sectionTitle[index.section]]?.count == 0{
            firstVC.sectionTitle.remove(at: index.section)
        }
        
        for i in 0..<firstVC.contactArray.count{
            if deleteContact?.firstName == firstVC.contactArray[i].firstName && deleteContact?.firstName == firstVC.contactArray[i].firstName{
                firstVC.contactArray.remove(at: i)
                let updateContact = Contacts(firstName: fname, secondName: sname, mobile: coName!.1, id: Int64())
                firstVC.contactArray.append(updateContact)
                firstVC.makeDict(in: firstVC.contactArray)
            }
        }
        phoneTableView.reloadData()
    }
    
    //MARK: Function to send data to edit controller
    @objc func editContact(){
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVC.firstName = fName
        editVC.secondName = sName
        editVC.numbers = coName?.1
        editVC.index = IndexPath()
        editVC.delegate = self
        
        navigationController?.pushViewController(editVC, animated: true)
        
    }
}
 
//MARK: Extension of Second view controller

extension secondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (coName?.1.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = phoneTableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondTableViewCell
        cell.numberType.text = labelArray[indexPath.row]
        print(coName?.1.count)
        cell.phoneNumber.text = coName?.1[indexPath.row]
        return cell
        
    }
    //MARK: Method to set height for rows in tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
