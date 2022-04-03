//
//  Errors.swift
//  Semaster WatchKit Extension
//
//  Created by Yū Kobayashi on 2022/04/03.
//

import Foundation

enum CheckinError: Error, LocalizedError {
    case unreachable
    case invalidReply
    
    var errorDescription: String? {
        return NSLocalizedString("Title.Error", comment: "Error")
    }
    
    var failureReason: String? {
        switch self {
        case .unreachable:
            return NSLocalizedString("Error.Unreachable", comment: "Unreachable")
        case .invalidReply:
            return NSLocalizedString("Error.Invalid", comment: "Invalid")
        }
    }
}
