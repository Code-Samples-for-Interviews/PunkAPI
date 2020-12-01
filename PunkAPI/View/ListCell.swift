//
//  ListCell.swift
//  PunkAPI
//
//  Created by Diego Jimenez on 22/10/2020.
//

import Foundation
import UIKit
import SDWebImage

class ListCell : UITableViewCell {
    static let cellHeight: CGFloat = 100.0
    static let cellReuseIdentifier = "ListCellId"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func prepareForReuse() {
        abvLabel.text = ""
        picture.image = nil
        nameLabel.text = ""
    }
    
    func configure(with beerViewModel: BeerViewModel) {
        self.nameLabel.text = beerViewModel.nameText
        self.abvLabel.text = String("\(beerViewModel.abvText)%")
        self.picture.sd_setImage(with: beerViewModel.pictureUrl)
    }
}
