import SwiftUI
import Combine
import MapKit

class SearchViewModel: BindableObject {
    private var searchPlacesStream: AnyCancellable?
    var didChange = PassthroughSubject<Void, Never>()

    weak var zoneListViewModel: ZoneListViewModel?
    let searchPlaces: SearchPlaces

    var placeName: String = "" {
        didSet {
            searchPlacesStream?.cancel()
            self.searchPlacesStream = AnyCancellable(searchPlaces.invoke(placeName: placeName)
                .sink { mapItems in
                    self.mapItems = mapItems
            })
        }
    }

    var mapItems: [Place] = [] {
        didSet {
            didChange.send(())
        }
    }

    var selectedPlace: Place? = nil {
        didSet {
            if let place = selectedPlace {
                zoneListViewModel?.places.append(place)
            }
        }
    }

    init(searchPlaces: SearchPlaces, zoneListViewModel: ZoneListViewModel) {
        self.searchPlaces = searchPlaces
        self.zoneListViewModel = zoneListViewModel
    }

    deinit {
        searchPlacesStream?.cancel()
    }
}
