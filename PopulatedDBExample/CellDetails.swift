//
//  CellDetails.swift
//  PopulatedDBExample
//
//  Created by John Diczhazy on 9/29/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class CellDetails: UITableViewCell {
    
    @IBOutlet var rowLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var orderNoLabel: UILabel!
    @IBOutlet var memoryLabel: UILabel!
    @IBOutlet var procLabel: UILabel!
    
    
    // Row Setter
    var row: String = "" {
        didSet {
            if (row != oldValue) {
                rowLabel.text = row
            }
        }
    }
    
    // Model Setter
    var model: String = "" {
        didSet {
            if (model != oldValue) {
                modelLabel.text = model
            }
        }
    }
    
    // Order Number Setter
    var orderNo: String = "" {
        didSet {
            if (orderNo != oldValue) {
                orderNoLabel.text = orderNo
            }
        }
    }
    
    // Processor Setter
    var proc: String = "" {
        didSet {
            if (proc != oldValue) {
                procLabel.text = proc
            }
        }
    }
    
    // Memory Setter
    var memory: String = "" {
        didSet {
            if (memory != oldValue) {
                memoryLabel.text = memory
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
