import UIKit

let calibri = "Calibri"
let calibriBold = "Calibri-Bold"
public let fontURL = Bundle.main.url(forResource: calibri, withExtension: "ttf")!
public let fontBoldURL = Bundle.main.url(forResource: calibriBold, withExtension: "ttf")!

public let paragraphStyle: NSParagraphStyle = {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    return paragraph
}()

public let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

let directoryName = "AppBuildersBadges"
let directory = documentsDirectory.appendingPathComponent(directoryName)

public func write(_ data: Data, name: String) {
    // Create directory if it doesn't exist
    try? FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: false, attributes: nil)
    do {
        try data.write(to: directory.appendingPathComponent("\(name).jpg"), options: [])
    }
    catch {
        print(error)
    }
}


public func flag(country: String) -> String {
    let base: UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}
