//
//  SimpleTestsViewController.swift
//  RxSwiftTest
//
//  Created by Juan Capponi on 1/26/21.
//

import UIKit
import RxSwift
import RxCocoa


class SimpleTestsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBOutlet weak var primeTextField: UITextField!
    
    
    fileprivate func behaviorRelayTest() {
        let a = BehaviorRelay(value: 1)
        let b = BehaviorRelay(value: 3)
        
        
        let c = Observable.combineLatest(a, b) {$0 + $1}
            .filter {$0 >= 0}
            .map {"\($0) is positive"}
        
        c.subscribe(onNext: {print($0)})
        b.accept(7)
        a.accept(5)
        b.accept(-1)
        a.accept(-1)
        a.accept(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        behaviorRelayTest()
    }
}
