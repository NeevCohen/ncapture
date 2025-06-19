//
//  ContentView.swift
//  ncapture
//
//  Created by Neev Cohen on 18/06/2025.
//

import SwiftUI
import snifferLib


struct ContentView: View {
    @State var number = 0
    @State var shouldCapture = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String(number))
            HStack {
                Button(action: {
                    shouldCapture = true
                    run()
                }) {
                    Image(systemName: "square.and.arrow.down")
                }.padding()
                Button(action: {
                    shouldCapture = false
                }) {
                    Image(systemName: "square.and.arrow.up")
                }.padding()
            }
        }
        .padding()
    }
    
    func run() {
        let workItem = DispatchWorkItem {
            var sniffer = Sniffer("en0")
            while (shouldCapture) {
                let capture = Array(sniffer.read_next_capture())
                DispatchQueue.main.async{
                    self.number = Int(capture[0])
                }
            }
            DispatchQueue.main.async{
                self.number = 0
            }
        }
        DispatchQueue.global().async(execute: workItem)
    }
}

#Preview {
    ContentView()
}
