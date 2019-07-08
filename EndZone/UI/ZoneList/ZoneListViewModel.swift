import SwiftUI
import Combine
import CoreLocation

class ZoneListViewModel: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()

    var cancellables: [String: AnyCancellable] = [:]

    var places: [Place] = [
        Place(
            name: "Cupertino",
            timeZone: TimeZone(identifier: "America/Los_Angeles")!,
            coordinate: CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0325086)
        ),
        Place(
            name: "Madrid",
            timeZone: TimeZone(identifier: "Europe/Paris")!,
            coordinate: CLLocationCoordinate2D(latitude: 40.4378698, longitude: -3.8196207)
        )
    ] {
        willSet {
            newValue.filter { $0.imageUrl == nil && cancellables[$0.name] == nil }.forEach { place in
                let sink = ImageApi().searchImages(query: place.name).receive(on: RunLoop.main).sink { url in
                    self.places.removeAll { $0 == place }
                    self.places.append(place.withImageUrl(url))
                    self.didChange.send()
                }
                cancellables[place.name] = AnyCancellable(sink)
            }
        }
        didSet {
            places.sort { (left, right) -> Bool in
                left.timeZone.secondsFromGMT() < right.timeZone.secondsFromGMT()
            }
            didChange.send()
        }
    }
}
