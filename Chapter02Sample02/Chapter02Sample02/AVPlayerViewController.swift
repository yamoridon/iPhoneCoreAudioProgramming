//
//  AVPlayerViewController
//  Chapter02Sample02
//
//  Created by Kazuki Ohara on 2019/03/21.
//  Copyright © 2019 Kazuki Ohara. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var levelMeterView: LevelMeterView!
    @IBOutlet weak var loopSwitch: UISwitch!
    @IBOutlet weak var prepareToPlaySwitch: UISwitch!

    var timer: Timer?
    var isNeedPrepareToPlay = false
    var player: AVAudioPlayer?

    deinit {
        stopTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "loop", ofType: "aif")!
        let fileURL = URL(fileURLWithPath: path)

        do {
            let player = try AVAudioPlayer(contentsOf: fileURL)
            player.delegate = self
            progressSlider.minimumValue = 0.0
            // スライダーの最大値をサウンドファイルの最大値にセットする
            progressSlider.maximumValue = Float(player.duration)
            progressSlider.value = 0.0
            // メータリングを On にする
            player.isMeteringEnabled = true
            self.player = player
        } catch {
            print(error)
        }
    }

    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 15.0, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player, player.isPlaying else {
                return
            }
            self.progressSlider.value = Float(player.currentTime)
            self.updateMeters()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func updateMeters() {
        guard let player = player else {
            return
        }

        // メーターリングのアップデート
        player.updateMeters()
        let dB = 20.0 * log10(player.volume)
        // peak と average を取得
        var peakDB = player.peakPower(forChannel: 0)
        var averageDB = player.averagePower(forChannel: 0)
        // 下げている分を追加する(レベルメーターのフェーダーを下げる)
        peakDB += dB
        averageDB += dB
        // player.volume を考慮した値となる

        // LevelMeterView での描画用に 0.0~1.0 の値に戻す
        let peak = pow(10.0, peakDB / 20.0)
        let average = pow(10.0, averageDB / 20.0)
        levelMeterView.average = CGFloat(average)
        levelMeterView.peak = CGFloat(peak)
    }

    // 通常のヴォリューム変更
    @IBAction func volumeSliderAction(_ slider: UISlider) {
        player?.volume = slider.value
    }

    // 音圧を考慮したヴォリューム変更
    @IBAction func dbSliderAction(_ slider: UISlider) {
        let volume = slider.value // slider の値(0.0〜1.0)を取得
        let rv = 1.0 / volume // 逆数
        let dB = -10.0 * log2(rv) // 逆数の log2 (2の何乗か)を求め -10 倍する
        player?.volume = pow(10.0, dB / 20.0) // デシベルを音の強さに戻す
    }

    @IBAction func setProgressAction(_ sender: Any) {
        stopTimer()
        player?.currentTime = TimeInterval(progressSlider.value)
        startTimer()
    }

    @IBAction func loopSwitchAction(_ switch: UISwitch) {
        player?.numberOfLoops = `switch`.isOn ? -1 : 0
    }

    @IBAction func prepareToSwitchAction(_ switch: UISwitch) {
        isNeedPrepareToPlay = `switch`.isOn
        if let player = player, isNeedPrepareToPlay {
            player.prepareToPlay()
        }
    }

    @IBAction func play(_ sender: Any) {
        if let player = player, !player.isPlaying {
            player.play()
            startTimer()
        }
    }

    @IBAction func stop(_ sender: Any) {
        if let player = player, player.isPlaying {
            stopTimer()
            player.stop()
            if isNeedPrepareToPlay {
                player.prepareToPlay()
            }
        }
    }

    @IBAction func pause(_ sender: Any) {
        if let player = player, player.isPlaying {
            player.pause()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopTimer()
    }
}

