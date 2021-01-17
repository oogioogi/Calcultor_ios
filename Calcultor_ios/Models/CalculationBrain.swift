//
//  CalculationBrain.swift
//  Calcultor_ios
//
//  Created by 이용석: 조선소 전기 쟁이 on 2021/01/16.
//

import Foundation

func multiply(first: Double, second: Double) -> Double {
    return first * second
}

func divide(first: Double, second: Double) -> Double {
    return first / second
}

func add(first: Double, second: Double) -> Double {
    return first + second
}

func sub(first: Double, second: Double) -> Double {
    return first - second
}
class CalculationBrain {
    
    private var accumulator = 0.0
    
    var operations: Dictionary<String,Operation> = [
        "∏": Operation.Constant(.pi),
        "√": Operation.Unaryoperator(sqrt),
        "×": Operation.Binaryoperator(multiply),
        //"×": Operation.Binaryoperator({ $0 * $1 }),
        "÷": Operation.Binaryoperator(divide),
        //"÷": Operation.Binaryoperator({ $0 / $1 }),
        "+": Operation.Binaryoperator(add),
        //"+": Operation.Binaryoperator({ $0 + $1 }),
        "-": Operation.Binaryoperator(sub),
        //"-": Operation.Binaryoperator({ $0 - $1 }),
        "%": Operation.Constant(0.01),
        "=": Operation.Equals,
        "AC": Operation.ClearAll
    ]
    
    enum Operation {
        case Constant(Double)
        case Unaryoperator((Double) -> Double)
        case Binaryoperator((Double, Double) -> Double)
        case Equals
        case ClearAll
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            switch constant {
            case .Constant(let value):
                accumulator = value * accumulator
                print("accumulator : \(accumulator) value : \(value)")
                
            case .Unaryoperator(let root):
                accumulator = root(accumulator)
                
            case .Binaryoperator(let function):
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstoperand: accumulator)
            
            case .Equals:
                if pending != nil {
                    print("first : \(pending!.firstoperand) secode : \(accumulator)")
                    accumulator = pending!.binaryFunction(pending!.firstoperand, accumulator)
                    pending = nil
                }
            case .ClearAll:
                pending = nil
            }
        }
    }

    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstoperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
