import Foundation
import WatchConnectivity

final class WatchController: NSObject, WCSessionDelegate {
    static let shared = WatchController()
    
    override init() {
        super.init()
        if (WCSession.isSupported()) {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Some message on session activation
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let count = applicationContext["count"] as? Int ?? 0
        let lastCheckin = applicationContext["last_checkin"] as? String ?? "Invalid"
        
        UserDefaults.standard.set(count, forKey: "CheckinsCount")
        UserDefaults.standard.set(lastCheckin, forKey: "LastCheckinDate")
    }
    
    // MARK: - Common functions
    
    func sendCheckinMessage(quality: Double, amount: Double, comment: String) throws {
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage([
                "type": "Checkin",
                "quality": quality,
                "amount": amount,
                "comment": comment,
            ], replyHandler: { reply in
                // TODO: Some error handling
            })
        } else {
            throw CheckinError.unreachable
        }
    }
}
