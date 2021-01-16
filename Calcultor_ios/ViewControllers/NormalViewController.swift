//
//  NormalViewController.swift
//  Calcultor_ios
//
//  Created by 이용석 on 2021/01/16.
//

import UIKit

class NormalViewController: UIViewController {
    
    @IBOutlet weak var ButtonCollectionView: UICollectionView!
    let numbers = KeyboardLayout.shared.normalNumbers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ButtonCollectionView.delegate = self
        self.ButtonCollectionView.dataSource = self
        
        self.ButtonCollectionView.contentInset = .init(top: 10, left: 10, bottom: 0, right: 10)
        // ViewCell에서 무형의 존재에서는 레지스트 해주어야함!
        ButtonCollectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
    }
    
}

extension NormalViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as? ButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        numbers[indexPath.section][indexPath.row].forEach { (numberString) in
            // if "0" < numberString && "9" > numberString { } 범위 연산자
            if "0"..."9" ~= numberString || numberString.description == "." {
                cell.numberLabel.backgroundColor = .darkGray
            }else if numberString == "C" || numberString == "%" || numberString == "$" {
                cell.numberLabel.backgroundColor = UIColor(white: 1, alpha: 0.7)
                cell.numberLabel.textColor = .black
            }
        }
        
        return cell
    }
    
}

extension NormalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        let sectionCount = CGFloat(ButtonCollectionView.numberOfSections)
        var rowCount = CGFloat(ButtonCollectionView.numberOfItems(inSection: indexPath.section))
        
        if rowCount == 3 {
            rowCount = rowCount + 1
        }
        
        width = (ButtonCollectionView.frame.width / rowCount) - 20
        height = (ButtonCollectionView.frame.height / sectionCount) - 20
        
        if indexPath.section == 4 && indexPath.row == 0 {
            width = width * 2 + 20
        }
        return .init(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NormalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
    }
}
