// 
// Copyright 2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import Foundation
import AnalyticsEvents

extension DecryptionFailure {
    
    public func toAnalyticsEvent() -> AnalyticsEvent.Error {
        
        let timeToDecryptMillis = self.timeToDecrypt != nil ? Int(self.timeToDecrypt! * 1000) : -1
                
                let isHistoricalEvent = self.eventLocalAgeMillis != nil ? (self.eventLocalAgeMillis! < 0) : false
                
                let errorName = (isHistoricalEvent && self.trustOwnIdentityAtTimeOfFailure == false)
                    ? AnalyticsEvent.Error.Name.HistoricalMessage
                    : self.reason.errorName
        
        return AnalyticsEvent.Error(
            context: self.context,
            cryptoModule: .Rust,
            cryptoSDK: .Rust,
            domain: .E2EE,
            eventLocalAgeMillis: self.eventLocalAgeMillis,
            isFederated: self.isFederated,
            isMatrixDotOrg: self.isMatrixOrg,
            name: errorName,
            timeToDecryptMillis: timeToDecryptMillis,
            userTrustsOwnIdentity: self.trustOwnIdentityAtTimeOfFailure,
            wasVisibleToUser: self.wasVisibleToUser
        )
    }
}
