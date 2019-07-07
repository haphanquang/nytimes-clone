//
//  StringHelper.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

infix operator +
extension Dictionary {
    static func +(left: Dictionary, right: Dictionary) -> Dictionary {
        var test = left
        for (key, value) in right {
            test[key] = value
        }
        return test
    }
}


extension UIImageView {
    func setImage(_ url: String,
        placeHolder: String? = nil,
        completion: ((UIImage?) -> ())?) {
        
        guard let url = URL(string: url) else {
            completion?(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion?(nil)
                    return
                }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}


extension String {
    var localized: String {
        return self
    }
}


extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}

extension Date {
    var timeAgo: String {
        return "\(Int(self.timeIntervalSinceNow))" + "miliseconds ago".localized
    }
}
