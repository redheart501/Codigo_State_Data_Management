//
//  DataManager.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import RxSwift
import RealmSwift
import Realm
//import SwiftyJSON

func taskToJSON(task: HealthConcernObj) -> [String: Any] {
    var json: [String: Any] = [:]
    json["health_concerns"] = task

    return json
}
func task2ToJSON(task: DietsObj) -> [String: Any] {
    var json: [String: Any] = [:]
    json["diets"] = task

    return json
}
func task3ToJSON(task: AllergiesObj) -> [String: Any] {
    var json: [String: Any] = [:]
    json["allergies"] = task

    return json
}
func task4ToJSON(task: lastQuzObj) -> [String: Any] {
    var json: [String: Any] = [:]
    json["is_daily_exposure"] = task.is_daily_exposure
    json["is_somke"] = task.is_somke
    json["alchol"] = task.alchol
    

    return json
}
class DataManager {
    static let shared = DataManager()
    private let realm = try! Realm()
    private let dataSubject = PublishSubject<simpleOutputData>()
    var dataObservable: Observable<simpleOutputData> {
        return dataSubject.asObservable()
    }
    
    func updateData(_ newData: simpleOutputData) {
        dataSubject.onNext(newData)
    }
    
    func deleteHealConcern(data: [HealthConcernModel]){
        try! realm.write{
            for i in data{
                let allTasks = realm.objects(HealthConcernObj.self).filter("id == \(i.id)")
                realm.delete(allTasks)
            }
        }
    }
    
    func saveHealthConcern(data: [HealthConcernModel]) {
        try! realm.write{
            
            let healthConcernObj = HealthConcernObj()
            
            for i in data{
                healthConcernObj.id = i.id
                healthConcernObj.name = i.name
                if realm.object(ofType: HealthConcernObj.self, forPrimaryKey: healthConcernObj.id) == nil {
                    realm.add(healthConcernObj)
                }
            }
          
            
        }
    }
    func deleteDiets(data: [DietsModel]) {
        
        try! realm.write{
//
            let dietsObj = DietsObj()
            for i in data{
                let allTasks = realm.objects(DietsObj.self).filter("id == \(i.id)")
                realm.delete(allTasks)
            }
            
            
        }
    }
    func saveDiets(data: [DietsModel]) {
        
        try! realm.write{
//            let allTasks = realm.objects(DietsObj.self)
//                  realm.delete(allTasks)
            let dietsObj = DietsObj()
            for i in data{
                dietsObj.id = i.id
                dietsObj.name = i.name
                if realm.object(ofType: DietsObj.self, forPrimaryKey: dietsObj.id) == nil {
                    realm.add(dietsObj)
                }
            }
            
            
        }
    }
    
    func deleteAllergies(data: [AllergiesModel]) {
       
       
        try! realm.write{

            let allergiesObj = AllergiesObj()
            for i in data{
                let allergiesObj = realm.objects(AllergiesObj.self).filter("id == \(i.id)")
                realm.delete(allergiesObj)
            }
            
            
        }
    }
    func saveAllergies(data: [AllergiesModel]) {
       
       
        try! realm.write{
//            let allTasks = realm.objects(AllergiesObj.self)
//            realm.delete(allTasks)
            let allergiesObj = AllergiesObj()
            for i in data{
                allergiesObj.id = i.id
                allergiesObj.name = i.name
                if realm.object(ofType: AllergiesObj.self, forPrimaryKey: allergiesObj.id) == nil {
                    realm.add(allergiesObj)
                }
            }
            
            
        }
    }
    func saveLastQuz(data : lastQuzModel){
        try! realm.write{
//            let allTasks = realm.objects(AllergiesObj.self)
//            realm.delete(allTasks)
            let lastQuz = lastQuzObj()
            lastQuz.is_somke = data.is_somke
            lastQuz.is_daily_exposure = data.is_daily_exposure
            lastQuz.alchol = data.alchol
            realm.add(lastQuz)
            
            
        }
    }
    
    func deleteAll(){
        try! realm.write {
          realm.deleteAll()
        }
    }
    func getData() -> [String : Any] {
        let result = realm.objects(HealthConcernObj.self)
        let result1 = realm.objects(DietsObj.self)
        let result2 = realm.objects(AllergiesObj.self)
        var combinedDictionary: [String: Any] = [:]
        if let data = realm.objects(HealthConcernObj.self).first {
            let json = taskToJSON(task: data)
            combinedDictionary.merge(json) { (current, _) in current }
        }
        if let data1 = realm.objects(HealthConcernObj.self).first {
            let json = taskToJSON(task: data1)
            combinedDictionary.merge(json) { (current, _) in current }
            
        }
        if let data2 = realm.objects(DietsObj.self).first {
            let json = task2ToJSON(task: data2)
            combinedDictionary.merge(json) { (current, _) in current }
           
        }
        if let data3 = realm.objects(AllergiesObj.self).first {
            let json = task3ToJSON(task: data3)
            combinedDictionary.merge(json) { (current, _) in current }
           
        }
        if let data4 = realm.objects(lastQuzObj.self).first {
            let json = task4ToJSON(task: data4)
            combinedDictionary.merge(json) { (current, _) in current }
          
        }
        print(combinedDictionary)
        return combinedDictionary
    }
}

class HealthConcernObj: Object {
    @Persisted(primaryKey: true)  var id: Int = 0
    @Persisted var name: String = ""
}
class DietsObj: Object {
    @Persisted(primaryKey: true)  var id: Int = 0
    @Persisted var name: String = ""
}
class AllergiesObj: Object {
    @Persisted(primaryKey: true)  var id: Int = 0
    @Persisted var name: String = ""
}
class lastQuzObj : Object{
    @Persisted var is_daily_exposure: Bool = false
    @Persisted var is_somke: Bool = false
    @Persisted var alchol: String = ""
}


