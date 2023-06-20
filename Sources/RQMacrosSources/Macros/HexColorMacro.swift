import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

// reference: https://www.avanderlee.com/swift/macros/

public struct HexColorMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard
            let firstExpression = node.argumentList.first?.expression,
            let input = firstExpression.as(IntegerLiteralExprSyntax.self)?.digits,
            case let .integerLiteral(hexString) = input.tokenKind,
            let hexDouble = Double(hexString)
        else {
            fatalError()
        }
            
        let hexInt = UInt(hexDouble)
        
        let red = hexInt.get(.red)
        let green = hexInt.get(.green)
        let blue = hexInt.get(.blue)
        return "UIColor(red: \(literal: red), green: \(literal: green), blue: \(literal: blue)"
    }
}

//extension UIColor {
//    public static func hex(_ hexValue: Int, alpha: CGFloat) -> UIColor {
//        UIColor(
//            red: hexValue.get(.red),
//            green: hexValue.get(.green),
//            blue: hexValue.get(.blue),
//            alpha: alpha
//        )
//    }
//}

extension UInt {
    func foo() {
        
    }
    enum ColorComponent: Int {
        case red = 16
        case green = 8
        case blue = 0
    }

    func get(_ colorComponent: ColorComponent) -> CGFloat {
        let shifted = self >> colorComponent.rawValue
        let filtered = shifted & 0xff
        return CGFloat(filtered) / 255.0
    }
}
