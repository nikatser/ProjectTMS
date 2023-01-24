import UIKit

class SliderCell: UICollectionViewCell {
    
    //MARK: --Properties
    
    static let reuseId = "SliderCell"
    
    var textLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        label.textColor = Constant.shared.mainColor
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 30)
        label.numberOfLines = 0
        label.textAlignment = .right
        
        return label
    }()
    
    var joinButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Join us", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: Constant.shared.mainNameFont, size: 30)
        button.backgroundColor = Constant.shared.mainColor
        button.layer.cornerRadius = 20
        button.isHidden = true
        
        return button
    }()
    
    var loginButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login to account", for: .normal)
        button.setTitleColor(Constant.shared.mainColor.withAlphaComponent(1), for: .normal)
        button.titleLabel?.font =  UIFont(name: Constant.shared.mainNameFont, size: 30)
        button.layer.cornerRadius = 20
        button.isHidden = true
        
        return button
    }()
    
    //MARK: -- Function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.addSubview(textLabel)
        contentView.addSubview(joinButton)
        contentView.addSubview(loginButton)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            textLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            loginButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            loginButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            loginButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            
            joinButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10),
            joinButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            joinButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            
        ])
    }
}
