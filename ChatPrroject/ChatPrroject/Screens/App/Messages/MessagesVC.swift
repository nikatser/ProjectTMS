import UIKit
import MessageKit

class MessagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: --Properties
    
    var chats: [String] = []
    var chatsID: [String] = []
    var chatsDate: [String] = []
    var currentUsers: [CurrentUser] = []
    
    let cellReuseIdentifier = "cell"
    
    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        
        setupViews()
        setupConstraints()
        
        tableView.reloadData()
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseId)
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
        ])}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MessageCell = self.tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseId) as! MessageCell
        for user in currentUsers {
            if user.userID == self.chats[indexPath.row] {
                cell.nameLabel.text = user.name
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let chatVC = ChatVC()
        chatVC.chatID = chatsID[indexPath.row]
        chatVC.otherSenderId = currentUsers[indexPath.row].userID
        navigationController?.pushViewController(chatVC, animated: true)
        chatVC.modalPresentationStyle = .overFullScreen
        update()
    }
    
    func getChats() {
        Service.shared.getAllChats { items in
            for item in items {
                self.chats.append(item.1)
                self.chatsID.append(item.0)
            }
            self.tableView.reloadData()
        }
    }
    
    func getUsers() {
        Service.shared.getAllUsers { users in
            self.currentUsers = users
            self.tableView.reloadData()
        }
    }
    
    func update() {
        chats = []
        chatsID = []
        chatsDate = []
        currentUsers = []
        
        getUsers()
        getChats()
        tableView.reloadData()
    }
    
}


