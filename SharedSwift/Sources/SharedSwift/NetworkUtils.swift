//
//  NetworkUtils.swift
//  SharedSwift
//
//  Created by Neev Cohen on 24/06/2025.
//

import snifferLib

public func getNetworkInterfacesNames() -> [String] {
    return Array(Set(get_interfaces_names().map { String($0) }))
}
