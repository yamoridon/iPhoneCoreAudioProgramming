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
}
