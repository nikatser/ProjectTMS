import UIKit

class MessageCell: UITableViewCell {
    
    //MARK: --Properties
    
    static let reuseId = "MessageCell"
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 25)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "dfghjkl"
        
        return label
    }()
    
    var personImageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .black.withAlphaComponent(0.5)
        
        return imageView
    }()
    
    //MARK: -- Function
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(personImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: personImageView.rightAnchor, constant: 5),
            
            contentView.bottomAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 10)
        ])}
}
