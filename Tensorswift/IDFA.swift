//
//  IDFA.swift
//  Tensorswift
//
//  Created by Bryan Marks on 5/3/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import Foundation
import AdSupport

class IDFA {
    // MARK: - Stored Type Properties
    static let shared = IDFA()
    
    // MARK: - Computed Instance Properties
    /// Returns `true` if the user has turned off advertisement tracking, else `false`.
    var limited: Bool {
        return !ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    }
    
    /// Returns the identifier if the user has turned advertisement tracking on, else `nil`.
    var identifier: String? {
        guard !limited else { return nil }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
