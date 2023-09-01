//
//  FilterView.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation
import UIKit
import SnapKit

protocol FilterViewDelegate {
    func didSelectOnFilterValue(withType: String)
}


final class FilterView: UIView {
    
    let categoriesArray = ["business",
                           "entertainment",
                           "general",
                           "health",
                           "science",
                           "sports",
                           "technology"]
    var delegate : FilterViewDelegate?
    
    private let capsuleCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareUI()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func prepareUI() {
        self.addSubview(capsuleCollectionView)

        capsuleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(50)
        }

    }

    private func setupCollectionView(){
        capsuleCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: "NewsCell")
        capsuleCollectionView.backgroundColor = .clear
        capsuleCollectionView.delegate = self
        capsuleCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.capsuleCollectionView.collectionViewLayout = layout
        capsuleCollectionView.showsHorizontalScrollIndicator = false

    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! FilterCell
        cell.titleLabel.text = categoriesArray[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Code here for protocol
        delegate?.didSelectOnFilterValue(withType: categoriesArray[indexPath.item])
    }
}
