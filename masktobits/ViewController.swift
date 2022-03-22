//
//  ViewController.swift
//  masktobits
//
//  Created by Yihong Wu on 2022/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calc(_ sender: UIButton) {
        if let ip = textfield.text?.ipv4() {
            result.text = ip.bits()
            result.sizeToFit()
        }
    }

}

extension Data {
    
    func bits() -> String {
        var n = 0
        var b = true
        for i in self.indices {
            let j = self[i].nonzeroBitCount
            let k = self[i].trailingZeroBitCount
            if j + k != 8 {
                return "Error: [\(i)] \(self[i]) nonzero \(j) trailing \(k)"
            }
            if b {
                if j == 8 {
                    n += 8
                } else {
                    n += j
                    b = false
                }
            } else {
                if j != 0 {
                    return "Error: [\(i)] \(self[i]) nonzero \(j)"
                }
            }
        }
        return String(n)
    }

}

extension String {

    func ipv4() -> Data? {
        let bytes = self.split(separator: ".", omittingEmptySubsequences: false)
        if bytes.count != 4 {
            return nil
        }
        var ip = Data(capacity: 4)
        for b in bytes {
            if let n = UInt8(b) {
                ip.append(n)
            } else {
                return nil
            }
        }
        return ip
    }
}
