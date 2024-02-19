import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct RQMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLInitMacro.self,
        HexColorMacro.self,
        LocalizableMacro.self
    ]
}
