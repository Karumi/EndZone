import Foundation
import Combine

protocol ImageApi {
    func searchImages(query: String) -> AnyPublisher<URL, Error>
}

struct PixabayImageApi: ImageApi {
    func searchImages(query: String) -> AnyPublisher<URL, Error> {
        return pixabaySearchImages(query: query)
            .compactMap { $0.hits.first?.largeImageURL }
            .compactMap { URL(string: $0) }
            .eraseToAnyPublisher()
    }

    private func pixabaySearchImages(query: String) -> AnyPublisher<Response, Error> {
        guard
            let url = URL(string: "https://pixabay.com/api/?key=12960822-78b5ff32b195d6f9d1d46ff23&image_type=photo&editors_choice=true&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")
            else { preconditionFailure("Can't create url for query: \(query)") }

        return request(url: url)
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func request(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in data }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

// MARK: - Response
struct Response: Codable {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String
    let webformatHeight: Int
    let webformatWidth: Int
    let likes: Int
    let imageWidth: Int
    let id: Int
    let userID: Int
    let views: Int
    let comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites: Int
    let imageSize: Int
    let previewWidth: Int
    let userImageURL: String
    let previewURL: String

    enum CodingKeys: String, CodingKey {
        case largeImageURL = "largeImageURL"
        case webformatHeight = "webformatHeight"
        case webformatWidth = "webformatWidth"
        case likes = "likes"
        case imageWidth = "imageWidth"
        case id = "id"
        case userID = "user_id"
        case views = "views"
        case comments = "comments"
        case pageURL = "pageURL"
        case imageHeight = "imageHeight"
        case webformatURL = "webformatURL"
        case type = "type"
        case previewHeight = "previewHeight"
        case tags = "tags"
        case downloads = "downloads"
        case user = "user"
        case favorites = "favorites"
        case imageSize = "imageSize"
        case previewWidth = "previewWidth"
        case userImageURL = "userImageURL"
        case previewURL = "previewURL"
    }
}
