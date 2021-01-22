//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Juan Capponi on 1/16/21.
//

import UIKit
import RxSwift
import RxCocoa




class ViewController: UIViewController {

    @IBOutlet weak var labelMotoElegida: UILabel!
    
    
    let disposeBag = DisposeBag()
    
    @IBAction func gitTable(_ sender: Any) {
        let gitTableVC = storyboard?.instantiateViewController(identifier: "gitTableVC") as! GitViewController
        navigationController?.pushViewController(gitTableVC, animated: true)
    }
    
    
    
    @IBAction func push(_ sender: Any) {
        
        let selectorVC = storyboard?.instantiateViewController(identifier: "selectorVC") as! SelectorViewController
        
        selectorVC.motoElegida.subscribe { [weak self] string in
            self!.labelMotoElegida.text = string
        }.disposed(by: disposeBag)

        navigationController?.pushViewController(selectorVC, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelMotoElegida.text = "Aún no elegiste moto de preferencia..."
   
    }


}

