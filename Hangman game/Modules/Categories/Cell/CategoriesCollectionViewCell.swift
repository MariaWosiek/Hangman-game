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
        contentView.backgroundColor = Constants.Colors.secondaryColor
        contentView.layer.cornerRadius = 12
        
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func configure(withCategory category: Category) {
        categoryLabel.text = category.categoryName
        categoryImageView.image = UIImage(named: category.categoryImage)
    }
}
