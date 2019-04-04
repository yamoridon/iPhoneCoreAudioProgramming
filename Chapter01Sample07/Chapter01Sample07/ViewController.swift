//
//  ViewController.swift
//  Chapter01Sample07
//
//  Created by Kazuki Ohara on 2019/03/21.
//  Copyright © 2019 Kazuki Ohara. All rights reserved.
//

import UIKit
import AVFoundation
import AudioExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let path = Bundle.main.path(forResource: "tap", ofType: ".aif")!
            let fileURL = URL(fileURLWithPath: path)
            let systemSoundID = try SystemSoundID.create(with: fileURL)
            let complete = try systemSoundID.completePlaybackIfAppDies()
            print("complete playback if app dies: \(complete)")
            try systemSoundID.dispose()
        } catch {
            print(error)
        }
    }


}

