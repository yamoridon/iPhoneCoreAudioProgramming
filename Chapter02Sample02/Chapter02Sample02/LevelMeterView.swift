//
//  LevelMeterView.swift
//  Chapter02Sample02
//
//  Created by Kazuki Ohara on 2019/04/07.
//  Copyright © 2019 Kazuki Ohara. All rights reserved.
//

import UIKit

class LevelMeterView: UIView {

    var peak = CGFloat(0.0) {
        didSet {
            setNeedsDisplay()
        }
    }

    var average = CGFloat(0.0) {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.clear(rect)

        context.setFillColor(UIColor.black.cgColor)
        context.fill(rect)

        context.setFillColor(UIColor.green.cgColor)
        let unit = rect.size.width / 200.0

        let peak = self.peak * 49.0
        let average = Int(self.average * 50.0)

        var x = CGFloat(0.0)
        for _ in 0..<average {
            let meterRect = CGRect(x: x, y: 0.0, width: unit * 3.0, height: rect.size.height)
            context.fill(meterRect)
            x += unit * 4.0
        }
        let meterRect = CGRect(x: peak * unit * 4.0, y: 0.0, width: unit * 3.0, height: rect.size.height)
        context.fill(meterRect)
    }
}
