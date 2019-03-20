//
//  AudioServiceError.swift
//  AudioExtension
//
//  Created by Kazuki Ohara on 2019/03/20.
//

import Foundation
import AudioToolbox

public enum AudioServiceError: Error {
    case unsupportedProperty
    case badPropertySize
    case badSpecifierSize
    case systemSoundUnspecified
    case systemSoundClientTimedOut
    case systemSoundExceededMaximumDuration
    case unknown(status: OSStatus)

    init(status: OSStatus) {
        switch status {
        case kAudioServicesUnsupportedPropertyError:
            self = .unsupportedProperty
        case kAudioServicesBadPropertySizeError:
            self = .badPropertySize
        case kAudioServicesBadSpecifierSizeError:
            self = .badSpecifierSize
        case kAudioServicesSystemSoundUnspecifiedError:
            self = .systemSoundUnspecified
        case kAudioServicesSystemSoundClientTimedOutError:
            self = .systemSoundClientTimedOut
        case kAudioServicesSystemSoundExceededMaximumDurationError:
            self = .systemSoundExceededMaximumDuration
        default:
            self = .unknown(status: status)
        }
    }
}
