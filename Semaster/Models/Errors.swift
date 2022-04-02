import Foundation

struct SemasterError: LocalizedError {
    var errorDescription: String?
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
    
    init(nsError: NSError, title: String, recovery: String) {
        self.errorDescription = title
        self.failureReason = nsError.localizedFailureReason
        self.recoverySuggestion = recovery
    }
    
    init(description: String, reason: String, recovery: String) {
        self.errorDescription = description
        self.failureReason = reason
        self.recoverySuggestion = recovery
    }
}
