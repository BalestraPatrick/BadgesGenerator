import UIKit

public func render(_ attendee: Attendee) -> Data {
    let renderer = UIGraphicsImageRenderer(bounds: CGRect(origin: .zero, size: CGSize(width: 1250, height: 1965)))
    let image = renderer.image { context in
        let rect = context.format.bounds
        UIColor.blue.setFill()
        context.fill(rect)
        #imageLiteral(resourceName: "badge-background.png").draw(in: rect)

        do {
            let fontSize = CGFloat(185)
            let attributes = [NSFontAttributeName: UIFont(name: calibriBold, size: fontSize)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: #colorLiteral(red: 0.2470588235, green: 0.2470588235, blue: 0.2470588235, alpha: 1)]
            let string = "\(attendee.firstName)\n\(attendee.lastName)"
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            let height = attributedString.boundingRect(with: CGSize(width: rect.width, height: 750), options: [.usesLineFragmentOrigin], context: nil).height
            let lines = Int(height / fontSize)
            let yPosition: CGFloat
            if lines == 1 {
                yPosition = CGFloat(950)
            } else if lines == 2 {
                yPosition = CGFloat(875)
            } else {
                yPosition = CGFloat(800)
            }
            attributedString.draw(with: CGRect(x: 0, y: yPosition, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

        do {
            let attributes = [NSFontAttributeName: UIFont(name: calibri, size: 125)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)]
            let string = attendee.company
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 1325, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

        do {
            let attributes = [NSFontAttributeName: UIFont(name: calibri, size: 150)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let string = flag(country: attendee.country)
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 1500, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }

        do {
            let attributes = [NSFontAttributeName: UIFont(name: calibri, size: 125)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 0.7)]
            let string = attendee.twitter
            let attributedString = NSAttributedString(string: string, attributes: attributes)
            attributedString.draw(with: CGRect(x: 0, y: 1750, width: rect.width, height: rect.height), options: .usesLineFragmentOrigin, context: nil)
        }
    }
    return UIImageJPEGRepresentation(image, 1)!
}
