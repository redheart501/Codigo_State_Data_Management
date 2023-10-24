//
//  WelcomeViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class WelcomeViewController : UIViewController{
    
    @IBAction func clickGetStarted(_ sender: Any) {
        let vc =   UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
