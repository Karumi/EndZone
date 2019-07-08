class CompositionRoot {
    static var shared: CompositionRoot = CompositionRoot()

    lazy var searchPlacesService: SearchPlacesService = {
        MapKitSearchPlaces()
    }()

    lazy var imageApi: ImageApi = {
        PixabayImageApi()
    }()

    lazy var zoneListViewModel = {
        ZoneListViewModel(searchImageByPlace: SearchImageByPlace(imageApi: imageApi))
    }()

    lazy var searchViewModel = {
        SearchViewModel(searchPlaces: SearchPlaces(searchPlacesService: searchPlacesService), zoneListViewModel: zoneListViewModel)
    }()
}
