//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ivan Riyanto on 01/09/23.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    lazy var cardView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.roundCorner(.allCorners, radius: 10)
        return view
    }()
    
    lazy var titleLabel : UITextView = {
        var label = UITextView()
        label.isScrollEnabled = false
        label.sizeToFit()
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        contentView.addSubview(titleLabel)
        
        runAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func runAutoLayout(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
    }
}

