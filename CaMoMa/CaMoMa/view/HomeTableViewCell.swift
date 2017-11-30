//
//  HomeTableViewCell.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/27/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

     @IBOutlet weak private var lbSub: UILabel!
    
     @IBOutlet weak private var lbAdd: UILabel!
    
    @IBOutlet weak var lbDateAdd: UILabel!
    @IBOutlet weak var lbDateSub: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(event: Event){
        if let money = event.money,
            let date = event.date {
                if money > 0 {
                    lbAdd.text = String(money.formattedWithSeparator)
                    lbSub.text = ""
                    lbDateAdd.text = date
                    lbDateSub.text = ""
                    
                } else {
                    lbAdd.text = ""
                    lbSub.text = String(money.formattedWithSeparator)
                    lbDateAdd.text = ""
                    lbDateSub.text = date
                }
            }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
