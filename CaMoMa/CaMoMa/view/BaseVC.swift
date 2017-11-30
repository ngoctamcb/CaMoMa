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
import FirebaseDatabase

class BaseVC: UIViewController {
    var disposeBag: DisposeBag!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disposeBag = DisposeBag()
        ref = Database.database().reference(fromURL: "https://camoma-61de8.firebaseio.com/")
        getBalance()
        hideKeyboardWhenTouchOutside()
        customView()
        react()
    }
    
    func react() {
        
    }
    
    func customView() {
        
    }
    
    func hideKeyboardWhenTouchOutside() {
        self.setHidenKeyboard()
    }
    
    func getBalance() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
