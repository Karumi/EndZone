import Foundation
import Combine
import SwiftUI
import SDWebImage

func loadImage(url: URL?) ->  AnyPublisher<Image, Never> {
    return Future<Image, Never> { fullfill in
        SDWebImageManager.shared.loadImage(with: url, progress: nil) { (uiimage, _, _, _, _, _) in
            if let uiimage = uiimage {
                DispatchQueue.main.async {
                    fullfill(.success(Image(uiImage: uiimage)))
                }
            }
        }
    }
    .eraseToAnyPublisher()
}
