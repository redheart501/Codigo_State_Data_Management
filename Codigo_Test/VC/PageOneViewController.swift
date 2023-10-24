//
//  PageOneViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 23/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class PageOneViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var healthConcernArray = [HealthConcernModel]()
    var prioritizeArray = [HealthConcernModel]()
    let jsonString = JsonData.healthConcernJson
    
    override func viewDidLoad() {
        setupCollectionView()
        setupTableView()
        let jsonData = Data(jsonString.utf8)
        do {
            let result = try JSONDecoder().decode(HealthConcernData.self, from: jsonData)
            let healthConcernData = result.data
            self.healthConcernArray = healthConcernData
            self.collectionView.reloadData()
        } catch { print(error) }
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
               
                self.prioritizeArray.append(self.healthConcernArray[indexPath.row])
                let data = simpleOutputData(health_concerns: self.prioritizeArray, diets: [], allergies: [])
                DataManager.shared.updateData(data)
                DataManager.shared.saveHealthConcern(data: self.prioritizeArray)
                self.tableView.reloadData()
 
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemDeselected
            .subscribe(onNext: { indexPath in
                print("Deselected item at indexPath: \(indexPath)")
                self.prioritizeArray = self.prioritizeArray.filter{$0.id != self.healthConcernArray[indexPath.row].id}
                let data = simpleOutputData(health_concerns: self.prioritizeArray, diets: [], allergies: [])
                DataManager.shared.updateData(data)
                DataManager.shared.deleteHealConcern(data: [self.healthConcernArray[indexPath.row]])
                self.tableView.reloadData()
                self.tableView.isEditing = true
            })
            .disposed(by: disposeBag)
       
            
    }
    
    func setupTableView(){

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        tableView.isEditing = true
//        tableView.allowsSelectionDuringEditing = true

    }
    
    func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
    }
}

extension PageOneViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.healthConcernArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthConcernCollectionCell", for: indexPath) as? healthConcernCollectionCell else {
           
            return UICollectionViewCell()
        }
        cell.lblName.text = self.healthConcernArray[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! healthConcernCollectionCell
        if cell.isSelected == true {
            cell.bgView.backgroundColor = #colorLiteral(red: 0.1838494539, green: 0.2609753311, blue: 0.3655027151, alpha: 1)
            cell.lblName.textColor = .white
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! healthConcernCollectionCell
        cell.bgView.backgroundColor = .clear
        cell.lblName.textColor = .black
    }
     
    
}

extension PageOneViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prioritizeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "prioritizeTableCell", for: indexPath) as? prioritizeTableCell else{
            return UITableViewCell()
        }
        cell.lblName.text = self.prioritizeArray[indexPath.row].name
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return true to allow all rows to be re-ordered, or you can specify conditions when to allow reordering.
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the data source to reflect the new order
        let movedItem = prioritizeArray.remove(at: sourceIndexPath.row)
        prioritizeArray.insert(movedItem, at: destinationIndexPath.row)
       
        let data = simpleOutputData(health_concerns: self.prioritizeArray, diets: [], allergies: [])
        DataManager.shared.updateData(data)
        DataManager.shared.saveHealthConcern(data: self.prioritizeArray)
        print(data)
    }
  
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // Define this method to allow both deletion and reordering
        return .none
    }
    
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // You can add logic here to prevent certain rows from being moved or specify a specific order.
        return proposedDestinationIndexPath
    }
    
}


