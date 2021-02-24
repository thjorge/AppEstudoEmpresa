//
//  EnterpriseTableViewCell.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 03/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

import UIKit

class EnterpriseTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeEmpresa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
