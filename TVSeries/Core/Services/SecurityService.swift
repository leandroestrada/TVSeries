//
//  SecurityService.swift
//  TVSeries
//
//  Created by leandro estrada on 22/04/25.
//

import Foundation

protocol SecurityServiceProtocol {
    var isPINSet: Bool { get }
    func setPIN(_ pin: String)
    func validatePIN(_ pin: String) -> Bool
    func removePIN()
}

final class SecurityService: SecurityServiceProtocol {
    private let userDefaults: UserDefaults
    private let pinKey = "user_pin"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var isPINSet: Bool {
        return userDefaults.string(forKey: pinKey) != nil
    }
    
    func setPIN(_ pin: String) {
        userDefaults.set(pin, forKey: pinKey)
    }
    
    func validatePIN(_ pin: String) -> Bool {
        guard let savedPIN = userDefaults.string(forKey: pinKey) else {
            return false
        }
        return savedPIN == pin
    }
    
    func removePIN() {
        userDefaults.removeObject(forKey: pinKey)
    }
} 
