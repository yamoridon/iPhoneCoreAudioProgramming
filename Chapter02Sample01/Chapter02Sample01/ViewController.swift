//
//  ViewController.swift
//  Chapter02Sample01
//
//  Created by Kazuki Ohara on 2019/03/21.
//  Copyright © 2019 Kazuki Ohara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var players = [AVAudioPlayer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "pad", ofType: "aif")!
        let fileURL = URL(fileURLWithPath: path)
        playSound(with: fileURL)
    }

    func playSound(with url: URL) {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.play()
            players.append(player)
        } catch {
            print(error)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        players.removeAll { $0 == player }
    }

    @IBAction func play(_ sender: Any) {
        let path = Bundle.main.path(forResource: "pad", ofType: "aif")!
        let fileURL = URL(fileURLWithPath: path)
        do {
            let player = try AVAudioPlayer(contentsOf: fileURL)
            player.delegate = self
            player.play()
            players.append(player)
        } catch {
            print(error)
        }
    }
}

