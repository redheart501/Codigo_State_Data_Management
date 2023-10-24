//
//  PageThreeViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
import WSTagsField
import RxSwift
import RxCocoa

class PageThreeViewController:UIViewController,UITextFieldDelegate{
    
    fileprivate let tagsField = WSTagsField()
    
    @IBOutlet fileprivate weak var tagsView: UIView!
    
    let disposeBag = DisposeBag()
    var allergiesArray = [AllergiesModel]()
    var selectedAllergies = [AllergiesModel]()
    var savedAllergies = [AllergiesModel]()
    let jsonString = JsonData.allergiesJson
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)
        
        tagsField.cornerRadius = 3.0
        tagsField.spaceBetweenLines = 10
        tagsField.spaceBetweenTags = 10
        
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //old padding
        
        tagsField.placeholder = ""
        
        tagsField.textField.returnKeyType = .continue
        tagsField.delimiter = ""
        
        tagsField.tintColor = .gray
        tagsField.selectedTextColor = .white
        tagsField.textDelegate = self
        textFieldEvents()
        
        let textObservable: Observable<String> =  tagsField.textField.rx.text.orEmpty.asObservable()
        
        textObservable
            .subscribe(onNext: { text in
                // Handle text changes here
                self.selectedAllergies = self.allergiesArray.filter{$0.name.capitalized.contains(text.capitalized)}
                self.tableView.reloadData()
                self.tableView.isHidden = self.selectedAllergies.count == 0
                
            })
            .disposed(by: disposeBag)
        
        // Configure table view
        tableView.register(CellClassForDropDown.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        tableView.rx.itemSelected
            .subscribe(onNext: {  indexPath in
                self.tableView.isHidden = true
                self.tagsField.text = self.selectedAllergies[indexPath.row].name
                
            })
            .disposed(by: disposeBag)
        
        
        
        let jsonData = Data(jsonString.utf8)
        do {
            let result = try JSONDecoder().decode(AllergiesData.self, from: jsonData)
            let dietsData = result.data
            print(allergiesArray)
            self.allergiesArray = dietsData
            
        } catch { print(error) }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagsField.beginEditing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tagsField.frame = tagsView.bounds
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    fileprivate func textFieldEvents() {
        tagsField.onDidAddTag = { field, tag in
            print("onDidAddTag", tag.text)
            self.savedAllergies.append(contentsOf: self.allergiesArray.filter{$0.name.capitalized.contains(tag.text.capitalized)})
            print(self.savedAllergies)
            DataManager.shared.saveAllergies(data: self.savedAllergies)
        }
        
        tagsField.onDidRemoveTag = { field, tag in
            print("onDidRemoveTag", tag.text)
            self.savedAllergies = self.savedAllergies.filter{$0.name.capitalized != tag.text.capitalized}
            print(self.savedAllergies)
            DataManager.shared.deleteAllergies(data: self.allergiesArray.filter{$0.name.capitalized.contains(tag.text.capitalized)})
        }
        
        tagsField.onShouldAcceptTag = { field in
            var isAccept = self.allergiesArray.filter{$0.name.capitalized == (field.text?.capitalized ?? "")}.count != 0
            return isAccept
        }
    }
}

extension PageThreeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedAllergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.selectedAllergies[indexPath.row].name
        
        return cell
    }
    
    
   

}
class CellClassForDropDown : UITableViewCell {
    
}
