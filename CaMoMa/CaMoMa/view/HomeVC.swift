//
//  HomeVC.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/23/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase



class HomeVC: BaseVC {

    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var moneyView: UIView!
    private var sodu: Int?
    
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(fromURL: "https://camoma-61de8.firebaseio.com/")
        getMoneyFromFireBase()
        
        setOnClickMoneyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMoneyFromFireBase() {
        self.ref.child("sodu").observe(DataEventType.value) { (snap) in
            if let sodu = snap.value as? Int {
                self.sodu = sodu
                self.lbMoney.text = String(sodu.formattedWithSeparator) + "đ"
                let format = NumberFormatter()
                format.numberStyle = .currency
                
            }
        }
    }
    
    override func react() {
        
    }
    
    func setOnClickMoneyView() {
        self.moneyView.isUserInteractionEnabled = true
        
        let moneyTap = UITapGestureRecognizer(target: self, action: #selector (self.showAlertAddMoney(_:)))
        self.moneyView.addGestureRecognizer(moneyTap)
        
    }
    
    @objc func showAlertAddMoney(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Add Money", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            let money = alert.textFields?.first?.text
            print(money!)
            self.addMoney(withMoney: Int(money!)!)
            
        }
        alert.addAction(nextAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        alert.addTextField { (textField) -> Void in
            textField.keyboardType = .numberPad
            textField.textColor = UIColor.blue
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMoney(withMoney money: Int) {
        self.sodu = self.sodu! + money
        self.ref.child("sodu").setValue(sodu)
    }

}
