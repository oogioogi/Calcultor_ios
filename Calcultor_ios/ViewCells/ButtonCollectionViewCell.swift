//
//  ButtonCollectionViewCell.swift
//  Calcultor_ios
//
//  Created by 이용석: 조선소 전기 쟁이 on 2021/01/16.
//

/*
    콜렉션 뷰의 셀을 위한 클래스 입니다.
    - isHighlighted를 재정의하여 키에 변화가 있을시 알파 값을 바꾸어 줍니다. : "didSet": 콤퓨티드 프로퍼티가 아주 유용히 쓰입니다.
    - 레이블을 배경색상, 글자 색상, 글자 정열, 글자 크기, 레비블을 동그랗게 만들기 위해서 "clipsToBounds = true" 도 씁니다.
    - 재 생성 할때는 사이즈의 반으로 라운드를 주면 원이 됩니다.
 
  [ .clipsToBounds = true ]
 하위 뷰가 뷰의 경계로 제한되는지 여부를 결정하는 부울 값입니다.
 이 값을 true로 설정하면 서브 뷰가 수신자의 경계에 잘립니다. false로 설정하면 프레임이 수신기의 가시적 경계를 넘어 확장되는 서브 뷰는 잘리지 않습니다. 기본값은 false입니다.

*/



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
