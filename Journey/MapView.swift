//
//  MapView.swift
//  Journey
//
//  Created by AK on 26/03/26.
//


import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            
            ForEach(viewModel.places) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundStyle(place.color)
                    }
                    .onTapGesture {
                        viewModel.selectPlace(place)
                    }
                }
            }
            
            MapPolyline(coordinates: viewModel.routeCoordinates)
                .stroke(.blue, lineWidth: 4)
        }
        .mapStyle(.standard)
        .ignoresSafeArea()
    }
}