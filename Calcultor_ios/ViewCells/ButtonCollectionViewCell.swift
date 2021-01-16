//
//  ButtonCollectionViewCell.swift
//  Calcultor_ios
//
//  Created by 이용석 on 2021/01/16.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                numberLabel.alpha = 0.5
            }else {
                numberLabel.alpha = 1
            }
        }
    }
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        
        numberLabel.frame.size = self.frame.size
        numberLabel.layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
