//
//  NetworkUtils.swift
//  ncapture
//
//  Created by Neev Cohen on 22/06/2025.
//

import snifferLib

func getNetworkInterfacesNames() -> [String] {
    return Array(Set(get_interfaces_names().map { String($0) }))
}
