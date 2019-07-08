//
//  ContentView.swift
//  EndZone
//
//  Created by Davide Mendolia on 28/06/2019.
//  Copyright © 2019 Karumi. All rights reserved.
//

import SwiftUI
import MapKit
import Combine
import Solar

extension Place {
    var color: (text: Color, background: Color) {
        let currentDate = Date()
        if let solar = Solar(coordinate: coordinate) {
            if solar.isDaytime, let sunrise = solar.sunrise, let sunset = solar.sunset {
                let interval = sunrise.distance(to: sunset)
                let slice = interval / 3
                let morning = sunrise + slice
                let afternoon = sunset - slice
                if (sunrise...morning) ~= currentDate {
                    return (.black, Color("Sunrise"))
                } else if (morning...afternoon) ~= currentDate {
                    return (.black, Color("Midday"))
                } else if (afternoon...sunset) ~= currentDate {
                    return (.black, Color("Sunset"))
                }
            } else {
                return (.white, Color("Night"))
            }
        }
        return (.black, .white)
    }
}

struct ZoneListView: View {
    @ObjectBinding
    var viewModel: ZoneListViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 0) {
                ForEach(viewModel.places.identified(by: \.name)) { place in
                    PlaceView(place: place)
                }
            }

            PresentationLink(destination: SearchView(searchViewModel: CompositionRoot.shared.searchViewModel)) {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            .padding(32)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PlaceView: View {
    let place: Place

    @State
    var background: Image?

    var body: some View {
        ZStack {
            background?
                .resizable()
                .aspectRatio(1.7769376181, contentMode: .fill)
                .relativeHeight(1.0)
                .clipped()
            VStack {
                Spacer()
                Text(place.name).color(place.color.text)
                Spacer()
                Text("\(formatTimezone(seconds: TimeInterval(place.timeZone.secondsFromGMT())))")
            }
            .padding()
                .frame(minWidth: 0.0, maxWidth: .infinity)
                .background(place.color.background.opacity(background == nil ? 1.0 : 0.8))
        }
        .onReceive(loadImage(url: place.imageUrl)) { newBackground in
            self.background = newBackground
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneListView(viewModel: CompositionRoot.shared.zoneListViewModel)
    }
}
#endif
