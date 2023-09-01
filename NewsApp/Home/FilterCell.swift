//
//  FilterCell.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation
import UIKit

final class FilterCell: UICollectionViewCell {
    lazy var mainBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.roundCorner(.allCorners, radius: 10)
        return view
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
        self.isAccessibilityElement = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.addSubview(mainBackgroundView)
        
        [titleLabel].forEach {
            mainBackgroundView.addSubview($0)
        }
        
        mainBackgroundView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(5)
            make.bottom.trailing.equalTo(contentView).inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mainBackgroundView)
            make.centerY.equalTo(mainBackgroundView)
        }

    }

}
