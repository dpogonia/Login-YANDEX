//
//  PersistanceService.swift
//  ProfilePage
//
//  Created by Dmitrii Pogonia on 25.03.2026.
//

import UIKit

protocol PersistenceServiceProtocol {
    func save(username: String)
    func save(switchState: Bool)
    func getUsername() -> String?
    func getSwitchState() -> Bool
    func clearData()
}
