class CompositionRoot {
    static var shared: CompositionRoot = CompositionRoot()

    lazy var searchPlacesService = {
        MapKitSearchPlaces()
    }()

    lazy var zoneListViewModel = {
        ZoneListViewModel()
    }()

    lazy var searchViewModel = {
        SearchViewModel(searchPlaces: SearchPlaces(searchPlacesService: searchPlacesService), zoneListViewModel: zoneListViewModel)
    }()
}
