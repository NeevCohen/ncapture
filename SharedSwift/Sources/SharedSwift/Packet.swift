//
//  Packet.swift
//  SharedSwift
//
//  Created by Neev Cohen on 24/06/2025.
//

import Foundation

public enum TransportProtocol {
    case TCP
    case UDP
}

public struct Packet: Identifiable {
    public let id = UUID()
    
    public let sourceMacAddress: String?
    public let destinationMacAddress: String?
    public let sourceIpAddress: String?
    public let destinationIpAddress: String?
    public let transportProtocol: TransportProtocol?
    public let sourcePort: Int?
    public let destinationPort: Int?
    public let data: [UInt8]
    
    public init(sourceMacAddress: String? = nil, destinationMacAddress: String? = nil, sourceIpAddress: String? = nil, destinationIpAddress: String? = nil, transportProtocol: TransportProtocol? = nil, sourcePort: Int? = nil, destinationPort: Int? = nil, data: [UInt8]) {
        self.sourceMacAddress = sourceMacAddress
        self.destinationMacAddress = destinationMacAddress
        self.sourceIpAddress = sourceIpAddress
        self.destinationIpAddress = destinationIpAddress
        self.transportProtocol = transportProtocol
        self.sourcePort = sourcePort
        self.destinationPort = destinationPort
        self.data = data
    }
}
