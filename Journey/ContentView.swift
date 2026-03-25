//
//  ContentView.swift
//  Journey
//
//  Created by AK on 25/03/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showSheet: Bool = false
    @State private var titleHeight: CGFloat = .zero
    
    @State private var cameraPosition: MapCameraPosition = .region(
          MKCoordinateRegion(
              center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
              span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
          )
      )
      
    
    let items = [
        ("sun.max.fill", "Sunny Days", "Clear skies and warm temperatures", Color.orange),
        ("cloud.rain.fill", "Rainy Season", "Heavy rainfall expected this week", Color.blue),
        ("wind", "Wind Speed", "Strong winds up to 45 km/h", Color.teal),
        ("snowflake", "Snow Alert", "Light snowfall in northern regions", Color.cyan),
        ("cloud.bolt.fill", "Thunderstorm", "Severe storm warnings issued", Color.purple),
        ("sun.max.fill", "Sunny Days", "Clear skies and warm temperatures", Color.orange),
        ("cloud.rain.fill", "Rainy Season", "Heavy rainfall expected this week", Color.blue),
        ("wind", "Wind Speed", "Strong winds up to 45 km/h", Color.teal),
        ("snowflake", "Snow Alert", "Light snowfall in northern regions", Color.cyan),
        ("cloud.bolt.fill", "Thunderstorm", "Severe storm warnings issued", Color.purple),
    ]
    
    var body: some View {
       
        ZStack {
                   // ✅ Apple Map fills entire screen
                   Map(position: $cameraPosition)
                       .mapStyle(.standard)
                       .ignoresSafeArea()
                   
                   // ✅ Show Sheet button pinned to bottom
                   VStack {
                       Spacer()
                       Button("Show Sheet") {
                           showSheet.toggle()
                       }
                       .buttonStyle(.borderedProminent)
                       .tint(.red)
                       .padding(.bottom, 30)
                   }
               }
        .sheet(isPresented: $showSheet) {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 12) {
                    
                    // 📌 Title + Desc
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Hi i am Sheet")
                            .font(.largeTitle.bold())
                        Text("Start Now and learn more about local whether intensity and how it affects your daily routine and outdoor plans.")
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: true) // ✅ Force full multiline layout
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                    .background(GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                // ✅ Wait for layout to fully settle with multiline text
                                DispatchQueue.main.async {
                                    titleHeight = proxy.size.height
                                }
                            }
                            .onChange(of: proxy.size.height) { _, newHeight in
                                // ✅ Re-capture if height changes after reflow
                                titleHeight = newHeight
                            }
                    })
                    
                    Divider()
                        .padding(.horizontal, 15)
                    
                    // 📜 Scrollable List
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                                let (icon, title, subtitle, color) = item
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(color.opacity(0.15))
                                            .frame(width: 46, height: 46)
                                        Image(systemName: icon)
                                            .font(.system(size: 20))
                                            .foregroundStyle(color)
                                    }
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(title)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text(subtitle)
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(.gray.opacity(0.6))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 15)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            }
            .interactiveDismissDisabled()
            .presentationDetents(
                titleHeight == .zero ? [.medium, .large] : [.height(titleHeight), .fraction(0.5), .large]
            )
            .presentationDragIndicator(.visible)
        }
    }
}
