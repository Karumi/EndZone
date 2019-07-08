//
//  SearchView.swift
//  EndZone
//
//  Created by Davide Mendolia on 28/06/2019.
//  Copyright © 2019 Karumi. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObjectBinding
    var searchViewModel: SearchViewModel

    @Environment(\.isPresented)
    var isPresented: Binding<Bool>?

    var body: some View {
        VStack(spacing: 0) {
            TextField("Place name", text: $searchViewModel[keyPath: \.placeName])
                .padding()
                .background(Color.gray)

            List(searchViewModel.mapItems.identified(by: \.name), action: { place in
                self.searchViewModel.selectedPlace = place
                self.isPresented?.value = false
            }) { mapItem in
                Text(mapItem.name)
                Text("\(formatTimezone(seconds: TimeInterval(mapItem.timeZone.secondsFromGMT())))")
            }
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: CompositionRoot.shared.searchViewModel)
    }
}
#endif
