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

    @IBOutlet weak var tbHistory: UITableView!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var moneyView: UIView!
    
    var listEvent: [Event] = []
    
    private var balance: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbHistory.delegate = self
        tbHistory.dataSource = self
        getBalance()
        getListEvent()
        
//        setOnClickMoneyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getBalance() {
        self.ref.child("balance").observe(DataEventType.value) { (snap) in
            if let sodu = snap.value as? Int {
                self.balance = sodu
                self.lbMoney.text = String(sodu.formattedWithSeparator) + "đ"
                let format = NumberFormatter()
                format.numberStyle = .currency
            }
        }
    }
    
    func getListEvent() {
        self.ref.child("listEvent").observe(DataEventType.childAdded) { [weak self] (snapEvent) in
            
            guard let strongSelf = self else { return }
            let id: String = snapEvent.key
            guard let date = snapEvent.childSnapshot(forPath: "date").value as? String,
                    let money = snapEvent.childSnapshot(forPath: "money").value as? Int,
                        let note = snapEvent.childSnapshot(forPath: "note").value as? String
                
            else {
                return
            }
            
            let event = Event(id: id, money: money, note: note, date: date)
            strongSelf.listEvent.append(event)
            
            DispatchQueue.main.async {
                print(strongSelf.listEvent.count)
                strongSelf.tbHistory.reloadData()
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
        self.balance = self.balance! + money
        self.ref.child("sodu").setValue(balance)
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listEvent.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.configCell(event: listEvent[indexPath.row])

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showToast(message: listEvent[indexPath.row].note!)
    }

    
}
