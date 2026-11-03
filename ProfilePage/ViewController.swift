import UIKit

class ViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    // MARK: UI elements
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome, superuser!"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let switchLabel: UILabel = {
        let sl = UILabel()
        sl.text = "Remember me"
        return sl
    }()
    
    private let switchButton: UISwitch = {
        let sb = UISwitch()
        sb.isOn = false
        return sb
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardHiding() // Настраиваем скрытие клавиатуры ⌨️
        displayData()
        bindViewModel()
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActions() {
        logInButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        // Добавляем отслеживание изменений текста ✍️
        usernameTextField.addTarget(self, action: #selector(usernameChanged), for: .editingChanged)
    }
    
    // Метод для скрытия клавиатуры при нажатии на экран 🖱️
    private func setupKeyboardHiding() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func usernameChanged() {
        viewModel.username = usernameTextField.text ?? ""
    }
    
    private func displayData() {
        usernameTextField.text = viewModel.username
        switchButton.isOn = viewModel.isRememberedOn
    }
    
    private func bindViewModel() {
        // Сигнал об успешном входе
        viewModel.onLoginComplete = { [weak self] in
            self?.showLoginAlert()
        }
        
        // Сигнал об изменении состояния кнопки 🔘
        viewModel.onButtonStateChange = { [weak self] isEnabled in
            self?.logInButton.isEnabled = isEnabled
            self?.logInButton.backgroundColor = isEnabled ? .blue : .systemGray4
        }
    }
    
    private func showLoginAlert() {
        let alert = UIAlertController(title: "Success", message: "User data saved!", preferredStyle: .alert)
        
        // Добавляем кнопку "OK"
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        // Показываем на экране
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let subviews = [welcomeLabel, usernameLabel, usernameTextField, passwordLabel, passwordTextField, switchLabel, switchButton, logInButton]
        
        subviews.forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            switchButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            switchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            // Привязываем лейбл к левому краю и центрируем его по вертикали относительно свитча
            switchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            switchLabel.centerYAnchor.constraint(equalTo: switchButton.centerYAnchor),
            
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func loginPressed() {
        viewModel.username = usernameTextField.text ?? ""
        viewModel.isRememberedOn = switchButton.isOn
        viewModel.loginPressed()
    }
}
