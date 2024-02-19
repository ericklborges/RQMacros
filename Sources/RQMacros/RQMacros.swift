import Foundation

@freestanding(expression)
public macro URL(_ string: String) -> URL = #externalMacro(module: "RQMacrosSources", type: "URLInitMacro")

#if canImport(UIKit)
import UIKit

@freestanding(expression)
public macro hexColor(_ hexadecimal: UInt) -> UIColor = #externalMacro(module: "RQMacrosSources", type: "HexColorMacro")
#endif

@freestanding(expression)
public macro localizable(_ key: String) -> String = #externalMacro(module: "ZPMacrosSources", type: "LocalizableMacro")
