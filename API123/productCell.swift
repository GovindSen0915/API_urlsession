//
//  productCell.swift
//  API123
//
//  Created by Govind Sen on 15/07/24.
//

import UIKit

class productCell: UITableViewCell {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
//    var product: Products? {
//        didSet {
//            self.configure()
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        configure()
    }
    
//    func configure() {
//        guard let product else { return }
//        titleLabel.text = product.title
//        descriptionLabel.text = product.description`
//    }

   
    
}
