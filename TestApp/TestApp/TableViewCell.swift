//
//  TableViewCell.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreUsuario: UILabel!

    @IBOutlet weak var cedulaUsuario: UILabel!
    
    @IBOutlet weak var telefonoUsuario: UILabel!
    
    @IBOutlet weak var estadoUsuario: UILabel!
    
    @IBOutlet weak var editarUsuario: UIButton!
    
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
