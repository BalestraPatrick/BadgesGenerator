import UIKit
import CoreImage

public func render(_ attendee: Attendee) -> Data {
    let renderer = UIGraphicsImageRenderer(bounds: CGRect(origin: .zero, size: CGSize(width: 1250, height: 1965)))
    let image = renderer.image { context in
        let rect = context.format.bounds
        UIColor.blue.setFill()
        context.fill(rect)
        UIImage(named: "badge-background-swift-alps-2017.jpg")!.draw(in: rect)

        do {
            let fontSize = CGFloat(175)
            let attributes = [NSAttributedString.Key.font: UIFont(name: calibriBold, size: fontSize)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)]
            let string = "\(attendee.firstName)\n\(attendee.lastName)"
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            let height = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
            let lines = Int(height / fontSize)
            let yPosition: CGFloat
            if lines == 1 {
                yPosition = CGFloat(330)
            } else if lines == 2 {
                yPosition = CGFloat(255)
            } else {
                yPosition = CGFloat(180)
            }
            attributedString.draw(with: CGRect(x: 0, y: yPosition, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

        do {
            let attributes = [NSAttributedString.Key.font: UIFont(name: calibri, size: 200)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let string = flag(country: attendee.country)
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 860, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

        do {
            let attributes = [NSAttributedString.Key.font: UIFont(name: calibri, size: 125)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let string: String
            if !attendee.twitter.isEmpty {
                string = attendee.twitter
            } else {
                string = attendee.company
            }
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 670, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }
    }

    return image.jpegData(compressionQuality: 1.0)!
}

public func renderBack(_ attendee: Attendee) -> Data {
    let renderer = UIGraphicsImageRenderer(bounds: CGRect(origin: .zero, size: CGSize(width: 1250, height: 1965)))
    let image = renderer.image { context in
        let rect = context.format.bounds
        UIColor.blue.setFill()
        context.fill(rect)
        UIImage(named: "badge-background-swift-alps-2017.jpg")!.draw(in: rect)

        let url = "https://appbuilders.ch/documents/\(attendee.firstName)-\(attendee.lastName).pkpass"
        let data = url.data(using: String.Encoding.ascii)

        if let qrFilter = CIFilter(name: "CIQRCodeGenerator"), let colorFilter = CIFilter(name: "CIFalseColor") {
            qrFilter.setDefaults()
            qrFilter.setValue(data, forKey: "inputMessage")

            let whiteColor: CIColor = CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            let backgroundColor: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
            colorFilter.setValue(whiteColor, forKey: "inputColor0")
            colorFilter.setValue(backgroundColor, forKey: "inputColor1")

            let transform = CGAffineTransform(scaleX: 5, y: 5)
            let barcodeSize: CGFloat = 500
            if let output = colorFilter.outputImage?.transformed(by: transform) {
                UIImage(ciImage: output).draw(in: CGRect(x: (rect.width / 2) - (barcodeSize / 2), y: 350, width: barcodeSize, height: barcodeSize))
            }
        }
    }
    return image.jpegData(compressionQuality: 1.0)!
}
