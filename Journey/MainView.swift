//
//  ContentView 2.swift
//  Journey
//
//  Created by AK on 26/03/26.
//


import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @State private var showSheet = true
    @State private var titleHeight: CGFloat = .zero
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel)
        }
        .sheet(isPresented: $showSheet) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    
                    // 🔥 HEADER (measured here)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Discover Places")
                            .font(.title.bold())
                        
                        Text("Browse locations, view them on the map, and follow the route connecting all selected points.")
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(15)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    DispatchQueue.main.async {
                                        titleHeight = proxy.size.height
                                    }
                                }
                                .onChange(of: proxy.size.height) { _, newHeight in
                                    titleHeight = newHeight
                                }
                        }
                    )
                    
                    Divider()
                    
                    // 👇 Pass ONLY list part
                    BottomSheetView(viewModel: viewModel)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }
            .interactiveDismissDisabled()
            .presentationDetents(
                titleHeight == .zero
                ? [.fraction(0.25), .medium, .large]
                : [.height(titleHeight), .fraction(0.5), .large]
            )
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.visible)
        }
    }
}
