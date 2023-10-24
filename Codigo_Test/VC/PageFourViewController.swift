//
//  PageFourViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit
enum Q3 :String{
    case low = "0 - 1";
    case medium = "2 - 5";
    case high = "5 +";
}

class PageFourViewController:UIViewController{
    
    @IBOutlet weak var btnQ1Yes: UIButton!
    
    @IBOutlet weak var btnQ1No: UIButton!
    
    @IBOutlet weak var btnQ2Yes: UIButton!
   
    @IBOutlet weak var btnQ2No: UIButton!
    
    @IBOutlet weak var btnQ3_1: UIButton!
    
    @IBOutlet weak var btnQ3_2: UIButton!
    
    @IBOutlet weak var btnQ3_3: UIButton!
    
    var Q1Answer : Bool!
    var Q2Answer : Bool!
    var Q3Answer : String = ""
    
    @IBAction func clickQ1(_ sender: UIButton) {
        if sender.tag == 1{
            Q1Answer = true
            btnQ1Yes.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            btnQ1No.setImage(UIImage(systemName: "circle"), for: .normal)
        }else{
            Q1Answer = false
            btnQ1Yes.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ1No.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
        let data = simpleOutputData(health_concerns: [], diets: [], allergies: [], is_daily_exposure:Q1Answer, is_somke: Q2Answer,alchol: Q3Answer)
        DataManager.shared.updateData(data)
    }
    
    @IBAction func clickQ2(_ sender: UIButton) {
        if sender.tag == 1{
            Q2Answer = true
            btnQ2Yes.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            btnQ2No.setImage(UIImage(systemName: "circle"), for: .normal)
        }else{
            Q2Answer = false
            btnQ2Yes.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ2No.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
        let data = simpleOutputData(health_concerns: [], diets: [], allergies: [], is_daily_exposure:Q1Answer, is_somke: Q2Answer,alchol: Q3Answer)
        DataManager.shared.updateData(data)
    }
    
    @IBAction func clickQ3(_ sender: UIButton) {
        if sender.tag == 1{
            Q3Answer = Q3.low.rawValue
            btnQ3_1.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            btnQ3_2.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ3_3.setImage(UIImage(systemName: "circle"), for: .normal)
        }else if sender.tag == 2{
            Q3Answer = Q3.medium.rawValue
            btnQ3_1.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ3_2.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            btnQ3_3.setImage(UIImage(systemName: "circle"), for: .normal)
        }else{
            Q3Answer = Q3.high.rawValue
            btnQ3_1.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ3_2.setImage(UIImage(systemName: "circle"), for: .normal)
            btnQ3_3.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
        let data = simpleOutputData(health_concerns: [], diets: [], allergies: [], is_daily_exposure:Q1Answer, is_somke: Q2Answer,alchol: Q3Answer)
        DataManager.shared.updateData(data)
    }
    
    
    
    
}
