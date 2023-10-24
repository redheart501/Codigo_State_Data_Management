//
//  OnboardingViewController.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 23/10/2023.
//

import Foundation
import UIKit
import RxSwift

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var btnGetPersonalized: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBAction func clickBack(_ sender: Any) {
        guard currentIndex != 0 else{
            self.navigationController?.popViewController(animated: true)
            return
        }
        onBoardingPageViewController?.turnPage(to: currentIndex-1,direction: .reverse)
    }
    
    @IBAction func clickNext(_ sender: Any) {
        self.btnGetPersonalized.isHidden = currentIndex != 2
        onBoardingPageViewController?.turnPage(to: currentIndex+1, direction: .forward)
       print( DataManager.shared.getData() )
    }
    
    @IBAction func clickGetPersonalized(_ sender: Any) {
        let sampleOutput = DataManager.shared.getData()
        
    }
    
    var currentIndex = 0
    var progess : [Float] = [0.25,0.5,0.75,1]
    weak var onBoardingPageViewController: OnboardingPageViewController?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.btnGetPersonalized.isHidden = true
        self.btn_next.isUserInteractionEnabled = false
        DataManager.shared.dataObservable
            .subscribe(onNext: { data in
                if data.is_daily_exposure != nil && data.is_somke != nil && data.alchol != ""{
            
                    let data = lastQuzModel(is_daily_exposure: data.is_daily_exposure,is_somke: data.is_somke,alchol: data.alchol)
                    DataManager.shared.saveLastQuz(data: data )
                }
                if data.health_concerns.isEmpty {
                    // Data is empty
                    print("Data is empty")
                    self.btn_next.isUserInteractionEnabled = false
                } else {
                    // Data is not empty
                    print("Data is not empty: \(data)")
                    self.btn_next.isUserInteractionEnabled = true
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onBoardingViewController = segue.destination as? OnboardingPageViewController {
            onBoardingViewController.pageViewControllerDelagate = self
            onBoardingPageViewController = onBoardingViewController
        }
    }
}

extension OnboardingViewController: onboardingPageViewControllerDelegate {

    func turnPageController(to index: Int) {
        currentIndex = index
        self.progressBar.progress = self.progess[index]
    }
}
