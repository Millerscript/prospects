//
//  LogViewCell.swift
//  TestApp
//
//  Created by Miller Mosquera on 26/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class LogViewCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var documento: UILabel!
    
    @IBOutlet weak var telefono: UILabel!
    
    @IBOutlet weak var estado: UILabel!
    
    @IBOutlet weak var fechaEditado: UILabel!
    
    @IBOutlet weak var iconEstado: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
