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

let directoryName = "SwiftAlpsBadges"
let directory = documentsDirectory.appendingPathComponent(directoryName)

CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
CTFontManagerRegisterFontsForURL(fontBoldURL as CFURL, CTFontManagerScope.process, nil)

public func render(_ attendee: Attendee) -> Data {

    let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: CGSize(width: 156, height: 241)))
    let data = renderer.pdfData { context in
        let rect = context.format.bounds
        context.beginPage(withBounds: rect, pageInfo: [:])
        UIImage(named: "background")!.draw(in: rect)

        var yPositionCompany = CGFloat(155)
//        do {
//            let optimalFont = CGFloat(20.0)
//            let attributes = [NSAttributedString.Key.font: UIFont(name: calibri, size: optimalFont)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)]
//            let string = attendee.company
//            let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
//            let height = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
//            let lines = Int(height / optimalFont)
//            if lines >= 2 {
//                // Check if we can fit everything into one line by decreasing font size
//                let newFont = CGFloat(15.0)
//                attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: calibri, size: newFont)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)], range: NSMakeRange(0, string.count))
//                let newHeight = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
//                let newLines = Int(newHeight / newFont)
//                if newLines == 2 {
//                    yPositionCompany = 150
//                }
//            }
//            attributedString.draw(with: CGRect(x: 0, y: yPositionCompany, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
//        }

        do {
            let fontSize = CGFloat(25)
            let attributes = [NSAttributedString.Key.font: UIFont(name: calibriBold, size: fontSize)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let string = "\(attendee.firstName.uppercased())\n\(attendee.lastName.uppercased())"
            let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
            let height = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
            var yPosition = CGFloat(143)
            let lines = Int(height / fontSize)
            if lines >= 3 {
                // Check if we can fit everything into one line by decreasing font size
                let newFont = CGFloat(20.0)
                yPosition += 5
                attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: calibriBold, size: newFont)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], range: NSMakeRange(0, string.count))
            }
            attributedString.draw(with: CGRect(x: 0, y: yPosition, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

//        do {
//            let attributes = [NSAttributedString.Key.font: UIFont(name: calibri, size: 25)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
//            let string = flag(country: attendee.country)
//            let attributedString = NSAttributedString(string: string, attributes: attributes)
//            attributedString.draw(with: CGRect(x: 0, y: 180, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
//        }

        do {
            let fontSize = CGFloat(20)
            let attributes = [NSAttributedString.Key.font: UIFont(name: calibri, size: fontSize)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)]
            if attendee.twitter.isEmpty == false && attendee.twitter != "-" {
                let string = attendee.twitter.hasPrefix("@") ? attendee.twitter : "@\(attendee.twitter)"
                let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
                let height = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
                let lines = Int(height / fontSize)
                if lines >= 2 {
                    let newFontSize = CGFloat(18)
                    attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: calibri, size: newFontSize)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)], range: NSMakeRange(0, string.count))
                }
                attributedString.draw(with: CGRect(x: 0, y: 205, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
            }
        }
    }
    return data
}

public func write(_ data: Data, name: String) {
    // Create directory if it doesn't exist
    try? FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: false, attributes: nil)
    do {
        try data.write(to: directory.appendingPathComponent("\(name).pdf"), options: [])
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

// Start rendering all attendees from JSON
print("👉🏻 Output directory: " + documentsDirectory.path)
Attendee.all().forEach {
    print("✅ Badge generated for \($0.firstName) \($0.lastName)")
    write(render($0), name: "\($0.firstName)-\($0.lastName)")
}
