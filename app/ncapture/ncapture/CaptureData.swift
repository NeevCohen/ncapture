//
//  CaptureData.swift
//  ncapture
//
//  Created by Neev Cohen on 23/06/2025.
//

import SwiftUI

struct CaptureData: View {
    @Binding var packets: [Packet]
    
    var body: some View {
        Table(packets) {
            TableColumn("Link") { packet in
                if (packet.sourceMacAddress == nil || packet.sourceMacAddress == nil) {
                    Text("")
                } else {
                    HStack {
                        Text(verbatim: "\(packet.sourceMacAddress!)")
                        Image(systemName: "arrow.right")
                        Text(verbatim: "\(packet.destinationMacAddress!)")
                    }
                }
            }
            TableColumn("Network") { packet in
                if (packet.sourceIpAddress == nil || packet.destinationIpAddress == nil) {
                    Text("")
                } else {
                    HStack {
                        Text(verbatim: "\(packet.sourceIpAddress!)")
                        Image(systemName: "arrow.right")
                        Text(verbatim: "\(packet.destinationIpAddress!)")
                    }
                }
            }
            TableColumn("Transport") { packet in
                if (packet.sourcePort == nil || packet.destinationPort == nil) {
                    Text("")
                } else {
                    HStack {
                        Text(verbatim: "\(packet.sourcePort!)")
                        Image(systemName: "arrow.right")
                        Text(verbatim: "\(packet.destinationPort!)")
                        if (packet.transportProtocol != nil) {
                            Text("(\(packet.transportProtocol!))")
                        }
                    }
                }
            }
            TableColumn("Application") { packet in
                Text("\(packet.data.map{ String(format:"%02X", $0) }.joined(separator: " "))")
            }
        }
    }
}
