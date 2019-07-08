import Foundation
import CoreLocation

struct Place: Equatable {

    let name: String
    let timeZone: TimeZone
    let coordinate: CLLocationCoordinate2D
    var imageUrl: URL?

    func withImageUrl(_ url: URL) -> Place {
        return Place(name: name, timeZone: timeZone, coordinate: coordinate, imageUrl: url)
    }
}

extension CLLocationCoordinate2D: Equatable {}

public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
