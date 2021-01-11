//
//  tableSectionHeader.swift
//  Flash Chat iOS13
//
//  Created by Artem Shuliak  on 1/9/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class TableSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerLabelContainer: UIView!
    
    func setup() {
        headerLabelContainer.layer.cornerRadius = headerLabelContainer.frame.height / 2
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    
}
