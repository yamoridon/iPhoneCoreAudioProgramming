import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController {

    var systemSoundID = SystemSoundID(0)

    override func loadView() {
        super.loadView()
        guard let path = Bundle.main.path(forResource: "tap", ofType: "aif") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            systemSoundID = try SystemSoundID.create(with: fileURL)
        } catch {
            print(error)
        }
    }

    @IBAction func play(_ sender: Any) {
        systemSoundID.play()
    }

    deinit {
        do {
            try systemSoundID.dispose()
        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "startup", ofType: "aif") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        playSystemSound(fileURL)
    }

    func playSystemSound(_ fileURL: URL) {
        do {
            let systemSound = try SystemSoundID.create(with: fileURL)
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
