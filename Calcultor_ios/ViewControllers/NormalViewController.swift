//
//  NormalViewController.swift
//  Calcultor_ios
//
//  Created by 이용석 on 2021/01/16.
//

import UIKit

class NormalViewController: UIViewController {
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var ButtonCollectionView: UICollectionView!
    
    var brain: CalculationBrain = CalculationBrain()
    let numbers = KeyboardLayout.shared.normalNumbers
    var isMiddleTyping = false
    var recoding: [String] = []
    
    private var stringRecord: String {
        get {
            return codeLabel.text!
        }
        set {
            codeLabel.text! += newValue
        }
    }
    
    private var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        
        set {
            let suffixString = String(newValue)
            if suffixString.hasSuffix(".0") {
                displayLabel.text = suffixString.replacingOccurrences(of: ".0", with: "")
            }else {
                displayLabel.text = suffixString
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ButtonCollectionView.delegate = self
        self.ButtonCollectionView.dataSource = self
        
        self.ButtonCollectionView.contentInset = .init(top: 10, left: 10, bottom: 0, right: 10)
        
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
            }else if numberString == "√" || numberString == "%" || numberString == "∏" {
                cell.numberLabel.backgroundColor = UIColor(white: 1, alpha: 0.7)
                cell.numberLabel.textColor = .black
            }else if numberString == "=" {
                cell.numberLabel.backgroundColor = .systemPink
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
        
//        if indexPath.section == 4 && indexPath.row == 0 {
//            width = width * 2 + 20
//        }
        return .init(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NormalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        
        switch number {
        case "0"..."9":
            if isMiddleTyping {
                var textCurrentlyInDisplayLabel = displayLabel.text
                if textCurrentlyInDisplayLabel!.hasPrefix("0"), !textCurrentlyInDisplayLabel!.hasPrefix("0.") {
                    textCurrentlyInDisplayLabel = ""
                }
                displayLabel.text = textCurrentlyInDisplayLabel! + number
            }else {
                displayLabel.text = number
            }
            isMiddleTyping = true
            
        case ".":
            if !confirmIncludeDecimalPoint(numberString: displayLabel.text!) {
                let textCurrentlyInDisplayLabel = displayLabel.text
                displayLabel.text = textCurrentlyInDisplayLabel! + number
            }
            
        case "AC":
            displayValue = 0.0
            brain.setOperand(operand: 0.0)
            codeLabel.text = ""
            
        case "=":
            stringRecord = displayLabel.text!
            
            if isMiddleTyping {
                brain.setOperand(operand: displayValue)
                isMiddleTyping = false
            }
            brain.performOperation(symbol: number)
            displayValue = brain.result
            stringRecord = " " + number + " "
            stringRecord = String(displayValue)
            
            recoding.append(stringRecord)
            
            print(recoding)

        default:
            stringRecord = displayLabel.text!
            
            if isMiddleTyping {
                brain.setOperand(operand: displayValue)
                isMiddleTyping = false
            }
            brain.performOperation(symbol: number)
            stringRecord = " " + number + " "
        }
        
    }
    
    private func confirmIncludeDecimalPoint(numberString: String) -> Bool {
        if numberString.range(of: ".") != nil || numberString.count == 0 {
            print("numberString : \(numberString)")
            return true
        }
        return false
    }
}


