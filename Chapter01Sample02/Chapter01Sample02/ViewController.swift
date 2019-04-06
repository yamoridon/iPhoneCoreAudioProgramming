import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController {
    @IBAction func play(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "tap", ofType: "aif") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            let systemSound = try SystemSoundID(url: fileURL)
            systemSound.play() {
                print("play did end")
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
