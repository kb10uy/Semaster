import Foundation
import WatchConnectivity

final class WatchController: NSObject, WCSessionDelegate {
    static let shared = WatchController()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let messageType = message["type"] as? String ?? ""
        
        switch messageType {
        case "Checkin":
            do {
                try checkinReceived(message: message)
            } catch {
                let error = error as NSError
                print("Checkin commit error: \(error.localizedDescription)")
            }
        default:
            print("Unknown message type: \(messageType)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    // MARK: - Common function
    
    func sendStatus(count: Int, lastDate: String) throws {
        try WCSession.default.updateApplicationContext([
            "count": count,
            "last_checkin": lastDate,
        ])
    }
    
    private func checkinReceived(message: [String: Any]) throws {
        let viewContext = PersistenceController.shared.container.viewContext
        try insertCheckin(
            viewContext: viewContext,
            quality: message["quality"] as! Double,
            amount: message["amount"] as! Double,
            comment: message["comment"] as! String
        )
        try updateWatchStatus(viewContext: viewContext)
    }
}
