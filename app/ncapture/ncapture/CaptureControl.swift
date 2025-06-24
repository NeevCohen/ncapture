//
//  CaptureControl.swift
//  ncapture
//
//  Created by Neev Cohen on 23/06/2025.
//

import SwiftUI
import SharedSwift

struct CaptureControl: View {
    let greenStartColor = 0x5C8374
    let redStopColor = 0x944452
    let buttonBackgroundColor = 0x222831
    
    @Binding var shouldCapture: Bool
    @Binding var selectedNetworkInterface: String?
    
    var isStartButtonDisabled: Bool {
        get {
            shouldCapture || selectedNetworkInterface == nil
        }
    }
    
    var isStopButtonDisabled: Bool {
        get {
            !shouldCapture
        }
    }
    
    var startButtonColor: Color {
        get {
            Color(hex: greenStartColor, opacity: isStartButtonDisabled ? 0.3 : 1)
        }
    }
    
    var stopButtonColor: Color {
        get {
            Color(hex: redStopColor, opacity: isStopButtonDisabled ? 0.3 : 1)
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                if (selectedNetworkInterface == nil) {
                    return
                }
                shouldCapture = true
            }) {
                Image(systemName: "play.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(startButtonColor)
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .disabled(isStartButtonDisabled)
            .background(Color(hex: buttonBackgroundColor))
            
            Menu(selectedNetworkInterface ?? "Select Network Interface") {
                ForEach(getNetworkInterfacesNames(), id: \.self) {name in
                    Button (name, action: {
                        self.selectedNetworkInterface = name
                    })
                }
            }
            .disabled(shouldCapture)
            .padding(.horizontal, 35)
            .frame(maxWidth: 600)
            
            Button(action: {
                if (selectedNetworkInterface == nil) {
                    return
                }
                shouldCapture = false
            }) {
                Image(systemName: "stop.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(stopButtonColor)
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .disabled(isStopButtonDisabled)
            .background(Color(hex: buttonBackgroundColor))
            
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var shouldCapture = false
    @Previewable @State var selectedNetworkInterface: String? = nil
    CaptureControl(shouldCapture: $shouldCapture,
                   selectedNetworkInterface: $selectedNetworkInterface)
}
