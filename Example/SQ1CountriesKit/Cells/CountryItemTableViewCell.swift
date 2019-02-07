//
//  CountryItemTableViewCell.swift
//  Riide
//
//  Created by Ricardo Antolin on 30/01/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

import UIKit
import SQ1CountriesKit

class CountryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return identifier
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSelected.image = UIImage(named: "tickIcon")?.withRenderingMode(.alwaysTemplate)
    }
    
    func setSelected() {
        let selectedColor = UIColor.blue
        lblName.textColor = selectedColor
        imgSelected.tintColor = selectedColor
        imgSelected.isHidden = false
    }
    
    func setUnSelected() {
        let unSelectedColor = UIColor.black
        lblName.textColor = unSelectedColor
        imgSelected.isHidden = true
    }
    
    func toggleSelected(_ selected: Bool){
        if selected {
            setSelected()
        }else {
            setUnSelected()
        }
    }
    
    func bindCountry(_ model: Country, selected: Bool = false){
        imgFlag.image = model.flag
        lblName.text = model.name
        toggleSelected(selected)
    }
}
