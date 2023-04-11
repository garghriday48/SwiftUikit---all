
import UIKit
var scenery = [
    sceneryData(sectionType: "Scene 1", imageGallery: ["1","2","3","4"]),
    sceneryData(sectionType: "Scene 2", imageGallery: ["5","6","7","1"]),
    sceneryData(sectionType: "Scene 3", imageGallery: ["2","3","4","5"]),
    sceneryData(sectionType: "Scene 4", imageGallery: ["6","7","3","4"])]

class ViewController: UIViewController {

    
    @IBOutlet var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.myCollectionView.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return scenery.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return scenery[section].sectionType
    }
}
