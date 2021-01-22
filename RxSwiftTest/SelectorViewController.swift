//
//  SelectorViewController.swift
//  RxSwiftTest
//
//  Created by Juan Capponi on 1/18/21.
//

import UIKit
import RxSwift
import RxCocoa


class SelectorViewController: UIViewController {

    
    @IBAction func yamahaButton(_ sender: UIButton) {
        print(sender.titleLabel?.text)
        setObservedVariable(string: (sender.titleLabel?.text)!)
    
    }
    
    
    @IBAction func hondaButton(_ sender: UIButton) {
        print(sender.titleLabel?.text)
        setObservedVariable(string: (sender.titleLabel?.text)!)
    }
    
    
    @IBAction func ktmButton(_ sender: UIButton) {
        print(sender.titleLabel?.text)
        
       
        
        setObservedVariable(string: (sender.titleLabel?.text)!)
    }
    
    let motoElegida = BehaviorRelay(value: " ")
    //let motoElegida = BehaviorSubject(value: " ")
    //var selectedOpcion = BehaviorSubject(value: "")
    //let stringObservale = Observable.just("")
    
    //var selectedTextOption: Observable<String> {
    //    selectedOpcion.asObserver()
    //}
    
    
    
    
    
    
    override func viewDidLoad() {
       // super.viewDidLoad

        
        
        
    }
    
    func setObservedVariable(string: String) {
       // stringObservale.
        motoElegida.accept(string)
        print("motoElegida..:\(string)")
    }
    
    
}
