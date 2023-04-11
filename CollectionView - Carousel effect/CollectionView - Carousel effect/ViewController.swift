//
//  ViewController.swift
//  CollectionView - Carousel effect
//
//  Created by Pragath on 23/02/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    let cellScaling: CGFloat = 0.6

    var sceneryImages: [String] = ["1","2","3","4","5","6","7"]
    
    @IBOutlet var page: UIPageControl!
    //let index = indexPath.item
    
    override func viewDidLoad() {
        super.viewDidLoad()
         page.currentPage = 0
         page.numberOfPages = sceneryImages.count

//MARK: for giving cell contraints programatically( for having cell in center)
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScaling)
//        let cellHeight = floor(screenSize.height * cellScaling)
//
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//        print(insetX,insetY)
//
//        let layout = myCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight )
//        myCollectionView.contentInset = UIEdgeInsets(top: insetY/2 , left: insetX + 20 , bottom: insetY, right: insetX + 20)
//        myCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sceneryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCollectionViewCell
        
        cell.image.image = UIImage(named: sceneryImages[indexPath.item])
        cell.image.layer.cornerRadius = 30
        
        return cell
    }
    
    //MARK: this is used before cell is visited
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        page.currentPage = indexPath.row
//    }
//
    @IBAction func pageFunction(_ sender: UIPageControl) {
        let index = IndexPath(item: sender.currentPage, section: 0)
        
        myCollectionView.scrollToItem(at: index, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}
    
    
    //mycollectionView.setContentOffset(self.contentOffset, animated: false)
    //myCollectionView.setContentOffset(insetX, animated: true)




