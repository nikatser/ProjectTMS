import Foundation
import MessageKit

struct LoginField {
    var email: String
    var password: String
}

struct ResponceCode {
    var code: Int
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct CurrentUser {
    var userID: String
    var name: String
}
