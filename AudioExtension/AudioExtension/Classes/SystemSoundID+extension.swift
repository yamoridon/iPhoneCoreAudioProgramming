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

    func play() {
        AudioServicesPlaySystemSound(self)
    }

    func addSystemSoundCompletion(
        in runLoop: CFRunLoop? = nil,
        mode: CFRunLoopMode = .defaultMode,
        clientData: UnsafeMutableRawPointer? = nil,
        completion: @escaping AudioServicesSystemSoundCompletionProc
    ) throws {
        let status = AudioServicesAddSystemSoundCompletion(self, runLoop, mode.rawValue, completion, clientData)
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
    }

    func dispose() throws {
        let status = AudioServicesDisposeSystemSoundID(self)
        if status != kAudioServicesNoError {
            throw AudioServiceError(status: status)
        }
    }

}
