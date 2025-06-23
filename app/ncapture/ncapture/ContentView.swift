//
//  ContentView.swift
//  ncapture
//
//  Created by Neev Cohen on 18/06/2025.
//

import SwiftUI
import snifferLib


struct ContentView: View {
    @State var shouldCapture = false
    @State var selectedNetworkInterface: String? = nil
    
    var body: some View {
        VStack {
            CaptureControl(
                shouldCapture: $shouldCapture,
                selectedNetworkInterface: $selectedNetworkInterface
            )
        }
    }
}

#Preview {
    ContentView()
}
