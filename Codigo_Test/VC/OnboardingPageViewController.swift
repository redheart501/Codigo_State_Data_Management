//
//  OnboardingPageViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 23/10/2023.
//

import Foundation
import UIKit


protocol onboardingPageViewControllerDelegate : AnyObject {
    func turnPageController(to index: Int)
}

class OnboardingPageViewController: UIPageViewController {
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "page1"),
            self.getViewController(withIdentifier: "page2"),
            self.getViewController(withIdentifier: "page3"),
            self.getViewController(withIdentifier: "page4")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    var currentIndex = 0
    weak var pageViewControllerDelagate: onboardingPageViewControllerDelegate?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func turnPage(to index:Int ,direction:UIPageViewController.NavigationDirection){
        currentIndex = index
        if index < 0 || index > 3 {
            return
        }
        setViewControllers([pages[currentIndex]], direction: direction, animated: true)
        self.pageViewControllerDelagate?.turnPageController(to: currentIndex)
    }

}

