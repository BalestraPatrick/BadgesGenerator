import Foundation

public struct Attendee {
    public let firstName: String
    public let lastName: String
//    public let company: String
    public let twitter: String
//    public let country: String
}

extension Attendee {

    public init(dictionary: [String: AnyObject]) {
        self.firstName = dictionary["first_name"] as! String
        self.lastName = dictionary["last_name"] as! String
//        self.company = dictionary["company"] as! String
        self.twitter = dictionary["twitter"] as! String
//        self.country = dictionary["country"] as! String
    }

    public static func all() -> [Attendee] {
        var attendees = [Attendee]()
        if let filePath = Bundle.main.path(forResource: "attendees", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
                let attendeesJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let attendeesArray = attendeesJSON as? [[String: AnyObject]] {
                    attendeesArray.forEach {
                        let attendee = Attendee(dictionary: $0)
                        attendees.append(attendee)
                    }
                }
            } catch {
                print("❌ Error parsing JSON file.")
            }
        } else {
            print("❌ No JSON file found with the given name.")
        }
        return attendees
    }
}
