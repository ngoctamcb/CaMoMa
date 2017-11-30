//
//  AddEventVC.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/27/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class AddEventVC: BaseVC {

    private var balance: Int?
    
    @IBOutlet weak var txtMoney: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtNote: UITextField!
    
    var object: Event?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearField()
    }
    
    override func getBalance() {
        self.ref.child("balance").observe(DataEventType.value) { (snap) in
            if let balance = snap.value as? Int {
                self.balance = balance
            }
        }
    }
    
    override func customView() {
        txtMoney.keyboardType = .numbersAndPunctuation
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        clearField()
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        if txtMoney.text != "" {
            var dic: [String: Any] = [String: Any]()
            dic.updateValue(txtNote.text!, forKey: "note")
            dic.updateValue(txtDate.text!, forKey: "date")
            
            if let money = Int(txtMoney.text!){
                dic.updateValue(money, forKey: "money")
                ref.child("listEvent").childByAutoId().setValue(dic)
                let newBalance = self.balance! + money
                ref.child("balance").setValue(newBalance)
                self.tabBarController?.selectedIndex = 1
                self.showToast(message: "Done")

            } else {
                self.showToast(message: "Bạn cần nhập số tiền")
            }

            
        } else {
            self.showToast(message: "Bạn cần nhập số tiền")
        }
        
        
    }
    
    func clearField() {
        txtMoney.text = ""
        txtNote.text = ""
        txtDate.text = getDateTimeCurrent()
    }
    func getDateTimeCurrent() -> String {
        var timeCurrent = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyy hh:mm:ss"
        
        let timeZone = TimeZone(identifier: "utc")
        
        dateFormatter.timeZone = timeZone
        
        let currentTime: String = dateFormatter.string(from: Date())
        return currentTime
        
    }
    
    

}
