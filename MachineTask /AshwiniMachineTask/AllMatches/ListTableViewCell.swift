//
//  ListTableViewCell.swift
//  AshwiniMachineTask
//


import UIKit

class ListTableViewCell: UITableViewCell {

    // All matches IBOutlets
    @IBOutlet weak var btnAstar: UIButton!
    @IBOutlet weak var lblAName: UILabel!
    @IBOutlet weak var lblAId: UILabel!
    @IBOutlet weak var backView: UIView!
    
   
    override func prepareForReuse() {
        super.prepareForReuse()
        btnAstar.setImage(UIImage(named: "star (1).png"), for: .normal)

    }
}
