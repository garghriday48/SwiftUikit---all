//
//  SecondViewController.swift
//  coreData
//
//  Created by Pragath on 10/03/23.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private let emp: EmployeeData = EmployeeData()
    var employees: [ModelEmployee]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        }
        // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        employees = emp.getAll()
        self.tableView.reloadData()
    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.employeeName.text = employees![indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        thirdVC.selectedEmployee = employees![indexPath.row]
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }   
}
