import MapKit
import Combine

class SearchImageByPlace {
    private var imageApi: ImageApi

    init(imageApi: ImageApi) {
        self.imageApi = imageApi
    }

    func invoke(query: String) -> AnyPublisher<URL, Error> {
        return imageApi.searchImages(query: query)
    }
}
