//
//  PageTwoViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PageTwoViewController:UIViewController{
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var dietArray = [DietsModel]()
    var selectedDiets = [DietsModel]()
    let jsonString = JsonData.dietJson
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        let jsonData = Data(jsonString.utf8)
        do {
            let result = try JSONDecoder().decode(DietsData.self, from: jsonData)
            let dietsData = result.data
            print(dietArray)
            self.dietArray = dietsData
            self.tableView.reloadData()
        } catch { print(error) }
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if indexPath.row == 0{
                    self.selectedDiets.removeAll()
                    self.tableView.reloadData()
                    return
                }
                let isSelected = self.selectedDiets.filter{$0.id == self.dietArray[indexPath.row-1].id}.count == 0 ? false : true
                
                if isSelected{
                    self.selectedDiets  = self.selectedDiets.filter{$0.id != self.dietArray[indexPath.row-1].id}
                    
                    DataManager.shared.deleteDiets(data: [self.dietArray[indexPath.row-1]])
                }else{
                    self.selectedDiets.append(self.dietArray[indexPath.row-1])
                    DataManager.shared.saveDiets(data: self.selectedDiets)
                }
                
                print(self.selectedDiets)
                
                self.tableView.reloadData()
               
              
            })
            .disposed(by: disposeBag)
    
    }
}
extension PageTwoViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
extension PageTwoViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dietArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DietTableViewCell", for: indexPath) as? DietTableViewCell else{
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            let isSelected = self.selectedDiets.count == 0
           cell.imgCheck.image = isSelected ? UIImage(systemName:"checkmark.square.fill") : UIImage(systemName:"square")
            cell.lblName.text = "none"
            cell.btnInfo.isHidden = true
            return cell
        }
        cell.btnInfo.isHidden = false
        if !selectedDiets.isEmpty{
            let isSelected = self.selectedDiets.filter{$0.id == self.dietArray[indexPath.row-1].id}.count == 0 ? false : true
            
            cell.imgCheck.image = isSelected ? UIImage(systemName:"checkmark.square.fill") : UIImage(systemName:"square")
        }else{
            cell.imgCheck.image = UIImage(systemName:"square")
        }
        cell.buttonAction = {
            let popoverVC = PopoverViewController()
            popoverVC.modalPresentationStyle = .popover
            popoverVC.popoverPresentationController?.sourceView = cell.btnInfo
            popoverVC.popoverPresentationController?.permittedArrowDirections = .up
            popoverVC.popoverPresentationController?.delegate = self
            popoverVC.text = self.dietArray[indexPath.row-1].tool_tip
            self.present(popoverVC, animated: true, completion: nil)
        }
        cell.lblName.text = self.dietArray[indexPath.row-1].name
        return cell
    }
    
}

class DietTableViewCell : UITableViewCell{
    
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnInfo: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var buttonAction: (() -> Void)?

        @IBAction func buttonTapped(_ sender: UIButton) {
            buttonAction?()
        }
}

class PopoverViewController: UIViewController {
    var text = ""
    
    override func viewDidLoad() {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        
        // Add the UILabel as a subview to the UIAlertController's contentView
        self.view.addSubview(label)
        
        // Define constraints for the label within the UIAlertController
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
        self.view.backgroundColor = .white
        self.preferredContentSize = CGSize(width: 300, height: 150)
    }
}
