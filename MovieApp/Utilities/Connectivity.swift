//
//  Connectivity.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import SystemConfiguration

class Connectivity {
    
    class var isConnectedToInternet: Bool {
        var zeroAddress: sockaddr_in = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability: SCNetworkReachability? = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable: Bool = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection: Bool = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret: (Bool) = (isReachable && !needsConnection)
        
        return ret
    }
}
