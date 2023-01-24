//
//  CategoriesCollectionViewCell.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        decorateCell()
    }

    private func decorateCell() {
        contentView.backgroundColor = UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func configure(withCategory category: Category) {
        categoryLabel.text = category.categoryName
        categoryImageView.image = UIImage(named: category.categoryImage)
    }
}
