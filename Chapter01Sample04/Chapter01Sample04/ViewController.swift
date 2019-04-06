import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "startup", ofType: "aif") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        playSystemSound(fileURL)
    }

    @IBAction func play(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "tap", ofType: "aif") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        playSystemSound(fileURL)
    }

    func playSystemSound(_ fileURL: URL) {
        do {
            let systemSound = try SystemSoundID(url: fileURL)
            systemSound.play() {
                do {
                    try systemSound.dispose()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}
