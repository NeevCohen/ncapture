//
//  ContentView.swift
//  ncapture
//
//  Created by Neev Cohen on 18/06/2025.
//

import SwiftUI
import snifferLib


struct ContentView: View {
    @State private var shouldCapture = false
    @State private var selectedNetworkInterface: String? = nil
    @State private var packets = [
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "bb:bb:bb:bb:bb:bb", sourceIpAddress: "192.168.0.3", destinationIpAddress: "192.168.0.1", transportProtocol: .TCP, sourcePort: 56114, destinationPort: 443, data: [16, 16, 16, 16]),
        Packet(sourceMacAddress: "bb:bb:bb:bb:bb:bb", destinationMacAddress: "aa:aa:aa:aa:aa:aa", sourceIpAddress: "192.168.0.1", destinationIpAddress: "192.168.0.3", transportProtocol: .TCP, sourcePort: 443, destinationPort: 56114, data: [150, 150, 100, 32, 14]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15]),
        Packet(sourceMacAddress: "aa:aa:aa:aa:aa:aa", destinationMacAddress: "ff:ff:ff:ff:ff:ff", sourceIpAddress: "192.168.0.3", destinationIpAddress: "0.0.0.0", transportProtocol: nil, sourcePort: nil, destinationPort: nil, data: [23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,23, 24, 244, 15,]),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            CaptureControl(
                shouldCapture: $shouldCapture,
                selectedNetworkInterface: $selectedNetworkInterface
            )
            .frame(minHeight: 100)
            CaptureData(packets: $packets)
        }
    }
}

#Preview {
    ContentView()
}
