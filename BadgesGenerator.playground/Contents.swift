import UIKit

CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
CTFontManagerRegisterFontsForURL(fontBoldURL as CFURL, CTFontManagerScope.process, nil)

// Render all attendees from JSON
print("👉🏻 Output directory: " + documentsDirectory.path)
Attendee.all().forEach {
    print("✅ Badge generated for \($0.firstName) \($0.lastName)")
    write(render($0), name: "\($0.firstName)-\($0.lastName)")
    write(renderBack($0), name: "\($0.firstName)-\($0.lastName)-back")
}
