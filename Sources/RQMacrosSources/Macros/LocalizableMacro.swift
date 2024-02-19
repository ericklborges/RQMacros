import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

import Foundation

public struct LocalizableMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        
        // Extract "key" argument
        guard
            let keyArgument = node.argumentList.first?.expression.as(StringLiteralExprSyntax.self),
            case let .stringSegment(keySegment) = keyArgument.segments.first
        else {
            throw MacroError.invalidParamKey
        }
        
        let key = keySegment.content.text
        
        
        // Get the calling site file path
        guard
            let fileLocation = context.location(of: node, at: .beforeLeadingTrivia, filePathMode: .filePath),
            let fileLocationSegment = fileLocation.file.as(StringLiteralExprSyntax.self)?.segments.first,
            case let .stringSegment(filePathSegment) = fileLocationSegment
        else {
            throw MacroError.unreachableFilePath
        }
        
        let filePath = filePathSegment.content.text
        
        // Get the bundle of the file
        let url = URL(fileURLWithPath: filePath, isDirectory: true)
        
        guard let bundle = Bundle(url: url) else {
            throw MacroError.invalidBundle(url.absoluteString)
        }
                
        let value = NSLocalizedString(key, bundle: bundle, comment: "")
        
        guard !value.isEmpty, value != key else { throw MacroError.invalidKey }
        
        return "\(literal: key).localized()"
    }
}

enum MacroError: Error {
    case invalidKey
    case missingEnglishTable
    case invalidNumberOfArguments
    case invalidParamKey
    case invalidParamBundle
    case invalidBundle(String)
    case invalidClass
    case unreachableFilePath
}
