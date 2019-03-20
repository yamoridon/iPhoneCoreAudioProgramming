import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController {

    var systemSoundID = SystemSoundID(0)
    var completionSoundID = SystemSoundID(0)

    override func loadView() {
        super.loadView()

        if let path = Bundle.main.path(forResource: "tap", ofType: "aif") {
            let fileURL = URL(fileURLWithPath: path)
            do {
                systemSoundID = try SystemSoundID.create(with: fileURL)
            } catch {
                print(error)
            }
        }

        if let path = Bundle.main.path(forResource: "completion", ofType: "aif") {
            let fileURL = URL(fileURLWithPath: path)
            do {
                completionSoundID = try SystemSoundID.create(with: fileURL)
            } catch {
                print(error)
            }
        }
    }

    @IBAction func playAlertSound(_ sender: Any) {
        systemSoundID.play(alert: true)
    }

    @IBAction func playSystemSound(_ sender: Any) {
        systemSoundID.play() { [weak self] in
            self?.playCompletionSound()
        }
    }

    func playCompletionSound() {
        completionSoundID.play()
    }

    deinit {
        do {
            try systemSoundID.dispose()
        } catch {
            print(error)
        }

        do {
            try completionSoundID.dispose()
        } catch {
            print(error)
        }
    }
}
