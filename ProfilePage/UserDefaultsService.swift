//
//  UserDefaultsService.swift
//  ProfilePage
//
//  Created by Dmitrii Pogonia on 25.03.2026.
//

import Foundation

class UserDefaultsService: PersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    
    // Ключи лучше держать внутри сервиса, так как это детали реализации хранения
    private enum Keys: String {
        case usernameKey
        case switchStateKey
    }
    
    func save(username: String) {
        userDefaults.set(username, forKey: Keys.usernameKey.rawValue)
    }
    
    func save(switchState: Bool) {
        userDefaults.set(switchState, forKey: Keys.switchStateKey.rawValue)
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: Keys.usernameKey.rawValue)
    }
    
    
    func getSwitchState() -> Bool {
        return userDefaults.bool(forKey: Keys.switchStateKey.rawValue)
    }
    
    func clearData() {
        userDefaults.removeObject(forKey: Keys.usernameKey.rawValue)
        userDefaults.removeObject(forKey: Keys.switchStateKey.rawValue)
    }
    
}
