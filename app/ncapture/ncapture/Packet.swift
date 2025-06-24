//
//  Packet.swift
//  ncapture
//
//  Created by Neev Cohen on 23/06/2025.
//

import Foundation

enum TransportProtocol {
    case TCP
    case UDP
}

struct Packet: Identifiable {
    let id = UUID()
    
    let sourceMacAddress: String?
    let destinationMacAddress: String?
    let sourceIpAddress: String?
    let destinationIpAddress: String?
    let transportProtocol: TransportProtocol?
    let sourcePort: Int?
    let destinationPort: Int?
    let data: [UInt8]
}
