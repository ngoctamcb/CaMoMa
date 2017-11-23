//
//  ViewController.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/23/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    

    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
    override func react() {
        txtPassword.rx.text
            .orEmpty
            .filter({$0.count == 6 && $0 == "123456"})
            .subscribe(onNext: { [unowned self] password in
                self.doLogin(password: password)
            }) => disposeBag
    }
    
    func doLogin(password: String) {
        print(password)
    }
    
    override func customView() {
        txtPassword.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


