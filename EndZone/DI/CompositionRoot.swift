class CompositionRoot {
    static var shared: CompositionRoot = CompositionRoot()

    lazy var zoneListViewModel = {
        ZoneListViewModel()
    }()

    lazy var searchViewModel = {
        SearchViewModel(searchPlaces: SearchPlaces(), zoneListViewModel: zoneListViewModel)
    }()
}
