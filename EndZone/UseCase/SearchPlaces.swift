import MapKit
import Combine

class SearchPlaces {
    private var searchPlacesService: SearchPlacesService

    init(searchPlacesService: SearchPlacesService) {
        self.searchPlacesService = searchPlacesService
    }

    func invoke(placeName: String) -> AnyPublisher<[Place], Error> {
        return searchPlacesService.query(placeName: placeName)
    }
}
