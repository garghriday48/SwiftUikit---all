

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenery[myCollectionView.tag].imageGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! myCollectionViewCell
        cell.myImage.image = UIImage(named: scenery[myCollectionView.tag].imageGallery[indexPath.row])
        return cell
    }
    
    
}
