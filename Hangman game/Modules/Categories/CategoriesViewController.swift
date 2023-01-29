//
//  CategoriesViewController.swift
//  Hangman game
//
//  Created by Maria Wosiek on 20/01/2023.
//

import UIKit

class CategoriesViewController: UIViewController, Storyboarded, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    var viewModel: CategoriesViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.estimatedItemSize = .zero
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.controllerDelegate = self
        collectionView.backgroundColor = .clear
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = viewModel.categories[indexPath.row]
        cell.configure(withCategory: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let choosenCategory = viewModel.categories[indexPath.row]
        viewModel.categoryTapped(choosenCategory: choosenCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let xPadding = 10
        let spacing = 30
        let rightPadding = 10
        let width = (UIScreen.main.bounds.size.width - CGFloat(xPadding + spacing + rightPadding))/2
        let height = CGFloat(215)

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 30, left: 10, bottom: 50, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}

// MARK: - CategoriesViewModelControllerDelegate
extension CategoriesViewController: CategoriesViewModelControllerDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
