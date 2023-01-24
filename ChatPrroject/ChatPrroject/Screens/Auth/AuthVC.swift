import UIKit

class AuthVC: UIViewController {
    
    //MARK: --Properties
    
    var userDefault = UserDefaults.standard
    
    lazy var appNavigationController = UINavigationController(rootViewController: AppTabBarC())
    
    //MARK: -- Views
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constant.shared.mainColor
        view.bounces = true
        
        return view
    }()
    
    let containerStackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constant.shared.mainColor
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        
        return view
    }()
    
    var backView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 77 + 84).isActive = true
        
        return view
    }()
    
    var buttonView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return view
    }()
    
    var iNputView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        return view
    }()
    
    //MARK: -- Labels
    
    var mainLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Authorization"
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 50)
        
        return label
    }()
    
    var emailLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = "Email:"
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 20)
        
        return label
    }()
    
    var passwordLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.widthAnchor.constraint(equalToConstant: 90).isActive = true
        label.text = "Password:"
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 20)
        
        return label
    }()
    
    //MARK: -- Buttons
    
    var backButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.setBackgroundImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        return button
    }()
    
    var signInButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(Constant.shared.mainColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.shared.mainNameFont, size: 25)
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 80).isActive = true
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(app), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: -- TextFields
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black.withAlphaComponent(0.3)
        textField.layer.cornerRadius = 10
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black.withAlphaComponent(0.3)
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(backView)
        containerStackView.addArrangedSubview(iNputView)
        containerStackView.addArrangedSubview(backButton)
        
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(backButton)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(signInButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            containerStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            containerStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 77),
            
            mainLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: 40),
            mainLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 77),
            backButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            
            emailLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 25),
            emailLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            emailTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            passwordTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            signInButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -40),
        ])
    }
    
    @objc
    func app(){
        if CheakValid.shared.validAuth(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            Service.shared.authApp(LoginField(email: emailTextField.text!, password: passwordTextField.text!)) {code in
                switch code.code{
                case 0:
                    print("ERROR")
                case 1:
                    print("OK")
                    let nextVC = self.appNavigationController
                    nextVC.modalPresentationStyle = .fullScreen
                    
                    self.present(nextVC, animated: true)
                    self.userDefault.setValue(true, forKey: "isLogin")
                default:
                    print("...")
                }
            }
        }
    }
    
    @objc
    func back(){
        let nextVC = SliderVC()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
}

