import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import RQMacrosSources

let testMacros: [String: Macro.Type] = [
    "hexColor": HexColorMacro.self
]
// "stringify": StringifyMacro.self

final class RQMacrosTests: XCTestCase {
    func test_HexColorMacro() {
        assertMacroExpansion(
            """
            #hexColor(0x123456)
            """,
            expandedSource: """
            UIColor()
            """,
            macros: testMacros
        )
    }
    
//    func testMacro() {
//        assertMacroExpansion(
//            """
//            #stringify(a + b)
//            """,
//            expandedSource: """
//            (a + b, "a + b")
//            """,
//            macros: testMacros
//        )
//    }

//    func testMacroWithStringLiteral() {
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//    }
}
