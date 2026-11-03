//
//  LoginViewModel.swift
//  ProfilePage
//
//  Created by Dmitrii Pogonia on 25.03.2026.
//

import UIKit



class LoginViewModel {
    
    enum Keys: String {
        case userDefaultsKey
        case switchStateKey
    }
    
    var username: String = "" {
        didSet {
            // Как только имя меняется, проверяем, должна ли кнопка быть активна
            validateInput()
        }
    }
    
    var isRememberedOn: Bool = false
    
    var onLoginComplete: (() -> Void)?
    
    var onButtonStateChange: ((Bool) -> Void)?
    
    //ссылка на сервис (протокол)
    private let persistence: PersistenceServiceProtocol
    
    init(persistence: PersistenceServiceProtocol) {
        self.persistence = persistence
        loadSavedData() // Загружаем данные при создании
    }
    
    private func loadSavedData() {
        self.username = persistence.getUsername() ?? ""
        self.isRememberedOn = persistence.getSwitchState()
        validateInput() // Проверяем при загрузке
    }
    
    // Логика валидации ✅
        private func validateInput() {
            let isEnabled = username.count >= 3
            onButtonStateChange?(isEnabled)
        }
    
    func loginPressed() {
        if isRememberedOn {
            persistence.save(username: username)
            persistence.save(switchState: true)
        } else {
            persistence.clearData()
        }
        onLoginComplete?()
    }
}
