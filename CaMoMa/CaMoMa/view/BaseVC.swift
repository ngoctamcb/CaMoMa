//
//  BaseVC.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/23/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

class BaseVC: UIViewController {
    var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchOutside()
        customView()
        self.disposeBag = DisposeBag()
        react()
    }
    
    func react() {
        
    }
    
    func customView() {
        
    }
    
    func hideKeyboardWhenTouchOutside() {
        self.setHidenKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
