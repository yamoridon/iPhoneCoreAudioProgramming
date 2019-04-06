//
//  ViewController.swift
//  Chapter01Sample09
//
//  Created by Kazuki Ohara on 2019/03/21.
//  Copyright © 2019 Kazuki Ohara. All rights reserved.
//

import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var systemSoundID: SystemSoundID?

    deinit {
        do {
            try systemSoundID?.dispose()
        } catch {
            print(error)
        }
    }

    override func loadView() {
        super.loadView()
        do {
            let path = Bundle.main.path(forResource: "tap", ofType: "aif")!
            let fileURL = URL(fileURLWithPath: path)
            systemSoundID = try SystemSoundID(url: fileURL)
            UIDevice.current.isProximityMonitoringEnabled = true
            NotificationCenter.default.addObserver(forName: UIDevice.proximityStateDidChangeNotification, object: nil, queue: nil) { [weak self] _ in
                print("UIDevice.current.proximityState = \(UIDevice.current.proximityState)")
                if UIDevice.current.proximityState {
                    kSystemSoundID_Vibrate.play()
                } else {
                    self?.systemSoundID?.play()
                }
            }
        } catch {
            print(error)
        }
    }
}

