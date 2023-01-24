import UIKit

class PeopleVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: --Properties
    
    var currentUsers: [CurrentUser] = []
    
    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var updateButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.setBackgroundImage(UIImage(named: "goforward"), for: .normal)
        
        return button
    }()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        update()
        
        setupViews()
        setupConstraints()
        
        tableView.register(PeopleCell.self, forCellReuseIdentifier: PeopleCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func setupViews(){
        view.addSubview(tableView)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        
            //updateButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            //updateButton.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -10),
        ])}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PeopleCell = self.tableView.dequeueReusableCell(withIdentifier: PeopleCell.reuseId) as! PeopleCell
        cell.nameLabel.text = self.currentUsers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        print(currentUsers[indexPath.row].userID)
        let chatVC = ChatVC()
        chatVC.otherSenderId = currentUsers[indexPath.row].userID
        navigationController?.pushViewController(chatVC, animated: true)
        chatVC.modalPresentationStyle = .overFullScreen
        update()
    }
    
    func getUsers() {
        Service.shared.getAllUsers { users in
            self.tableView.reloadData()
            self.currentUsers = users
            self.tableView.reloadData()
        }
    }
    
    func update() {
        currentUsers = []
        getUsers()
        tableView.reloadData()
    }
}

