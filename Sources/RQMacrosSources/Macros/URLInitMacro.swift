import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct URLInitMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard
            let firstExpression = node.argumentList.first?.expression,
            let stringLiteral = firstExpression.as(StringLiteralExprSyntax.self),
            stringLiteral.segments.count == 1,
            let firstSegment = stringLiteral.segments.first,
            case let .stringSegment(urlStringSegment) = firstSegment
        else {
            // TODO: throw error instead
            fatalError("compiler bug: the macro does not have any arguments")
        }
        
        let urlString = urlStringSegment.content.text
        
        guard let _ = URL(string: urlString) else {
            throw URLInitMacroError.invalidUrl(urlString)
        }
        
        return "URL(string: \(literal: urlString))!"
    }
}

enum URLInitMacroError: Error, CustomStringConvertible {
    case invalidUrl(String)
    
    var description: String {
        switch self {
        case let .invalidUrl(url): "Invalid URL: \(url)"
        }
    }
}
