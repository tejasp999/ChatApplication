//
//  AvatarPickerViewController.swift
//  SmackApp
//
//  Created by Teja PV on 3/5/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var avatarCollection: UICollectionView!
    
    var avatarType = AvatarType.dark
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarCollection.delegate = self
        avatarCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath:  NSIndexPath) -> CGSize {
        
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - ((numOfColumns-1)*spaceBetweenCells))/numOfColumns
        return CGSize(width: cellDimension, height:cellDimension)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == AvatarType.dark{
            UserService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else{
            UserService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func controlChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0{
            avatarType = AvatarType.dark
        }else{
            avatarType = AvatarType.light
        }
        avatarCollection.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
