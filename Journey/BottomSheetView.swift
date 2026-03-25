//
//  BottomSheetView.swift
//  Journey
//
//  Created by AK on 26/03/26.
//

import SwiftUI
struct BottomSheetView: View {
    
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Divider().padding(.horizontal, 15)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.places) { place in
                            PlaceRowView(
                                place: place,
                                isSelected: viewModel.selectedPlace == place
                            )
                            .id(place.id)
                            .onTapGesture {
                                viewModel.selectPlace(place)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
                }
                .onChange(of: viewModel.selectedPlace?.id) { oldValue, newValue in
                    if let id = newValue {
                        withAnimation {
                            proxy.scrollTo(id, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}
