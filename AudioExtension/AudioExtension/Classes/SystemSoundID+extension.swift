import Foundation
import AudioToolbox

public extension SystemSoundID {

    static func create(with fileURL: URL) throws -> SystemSoundID {
        var systemSoundID = SystemSoundID(0)
        let status = AudioServicesCreateSystemSoundID(fileURL as CFURL, &systemSoundID)
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
        return systemSoundID
    }

    func dispose() throws {
        let status = AudioServicesDisposeSystemSoundID(self)
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
    }

    func play(alert: Bool = false, completion: @escaping (() -> Void) = {}) {
        if alert {
            AudioServicesPlayAlertSoundWithCompletion(self, completion)
        } else {
            AudioServicesPlaySystemSoundWithCompletion(self, completion)
        }
    }

    func completePlaybackIfAppDies() throws -> Bool {
        var specifier = self
        let specifierSize = UInt32(MemoryLayout<SystemSoundID>.size)
        var propertyData = UInt32(0)
        var propertyDataSize = UInt32(MemoryLayout<UInt32>.size)
        let status = AudioServicesGetProperty(
            kAudioServicesPropertyCompletePlaybackIfAppDies,
            specifierSize,
            &specifier,
            &propertyDataSize,
            &propertyData
        )
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
        return propertyData != 0
    }

    func setCompletePlaybackIfAppDies(_ complete: Bool) throws {
        var specifier = self
        let specifierSize = UInt32(MemoryLayout<SystemSoundID>.size)
        var propertyData = complete ? UInt32(1) : UInt32(0)
        let propertyDataSize = UInt32(MemoryLayout<UInt32>.size)
        let status = AudioServicesSetProperty(
            kAudioServicesPropertyCompletePlaybackIfAppDies,
            specifierSize,
            &specifier,
            propertyDataSize,
            &propertyData
        )
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
    }

}
