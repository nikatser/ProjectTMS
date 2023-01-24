import MessageKit
import Foundation
import UIKit
import InputBarAccessoryView


class ChatVC: MessagesViewController {
    
    //MARK: --Properties
    
    var chatID: String?
    
    var otherSenderId: String?
    
    let selfSender = Sender(senderId: "1", displayName: "me")
    
    let otherSender = Sender(senderId: "2", displayName: "")
    
    var messages = [Message]()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnInputBarHeightChanged = true
        showMessageTimestampOnSwipeLeft = true
        
        messagesCollectionView.reloadData()
        //messagesCollectionView.scrollToLastItem(animated: false)
        
        messageInputBar.delegate = self
        
        if chatID == nil{
            Service.shared.getConversationId(otherID: otherSenderId!) { [weak self] chtID in
                self?.chatID = chtID
            }
        } else {
            self.getMessages(conversationID: chatID!)
        }
        
    }
    
    func getMessages(conversationID: String) {
        Service.shared.getAllMessages(chatID: conversationID) { [weak self] messages in
            self?.messages = messages
            self?.messagesCollectionView.reloadDataAndKeepOffset()
        }
    }
    
}

//MARK: -- Extension

extension ChatVC: MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {
    
    var currentSender: SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func backgroundColor(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? Constant.shared.mainColor : .black.withAlphaComponent(0.1)
    }
}

extension ChatVC: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        var msg = Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
        messages.append(msg)
        print(self.chatID)
        Service.shared.sendMessage(otherID: self.otherSenderId!, conversationID: self.chatID, text: text) { [weak self] convID in
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
            self!.chatID = convID
            
        }
    }
}
