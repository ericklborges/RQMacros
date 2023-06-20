import SwiftUI
import RQMacros

struct ContentView: View {
    var body: some View {
        Color(uiColor: .blue)
            .ignoresSafeArea(.all)
            .onAppear {
                let color = #hexColor(0x123451)
            }
    }
}

#Preview {
    ContentView()
}
