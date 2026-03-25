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
    
    let items: [Place] = [
        Place(name: "Cafe Aroma", description: "Best coffee in town", latitude: 37.7749, longitude: -122.4194, color: .orange),
        Place(name: "Pizza Hub", description: "Italian style pizza", latitude: 37.7840, longitude: -122.4090, color: .red),
        Place(name: "Green Garden", description: "Vegan restaurant", latitude: 37.7640, longitude: -122.4290, color: .green),
        Place(name: "Spicy Treat", description: "Indian spicy food", latitude: 37.7540, longitude: -122.4390, color: .purple),
        
        Place(name: "Burger Point", description: "Juicy burgers & fries", latitude: 37.7790, longitude: -122.4180, color: .pink),
        Place(name: "Sushi World", description: "Fresh sushi & rolls", latitude: 37.7815, longitude: -122.4120, color: .blue),
        Place(name: "Taco Fiesta", description: "Mexican street food", latitude: 37.7700, longitude: -122.4300, color: .yellow),
        Place(name: "BBQ Nation", description: "Grilled & BBQ specials", latitude: 37.7680, longitude: -122.4150, color: .brown),
        
        Place(name: "Pasta Corner", description: "Authentic Italian pasta", latitude: 37.7760, longitude: -122.4250, color: .mint),
        Place(name: "The Salad Bar", description: "Healthy salads & bowls", latitude: 37.7725, longitude: -122.4210, color: .green),
        Place(name: "Coffee House", description: "Premium coffee blends", latitude: 37.7785, longitude: -122.4170, color: .orange),
        Place(name: "Street Bites", description: "Quick street snacks", latitude: 37.7695, longitude: -122.4280, color: .teal),
        
        Place(name: "Royal Dine", description: "Fine dining experience", latitude: 37.7820, longitude: -122.4100, color: .indigo),
        Place(name: "Ice Cream Hub", description: "Delicious desserts", latitude: 37.7755, longitude: -122.4145, color: .cyan),
        Place(name: "Wok Express", description: "Chinese fast food", latitude: 37.7710, longitude: -122.4230, color: .red),
        Place(name: "Biryani Palace", description: "Hyderabadi biryani", latitude: 37.7670, longitude: -122.4320, color: .purple),
        
        Place(name: "Dosa Plaza", description: "South Indian delicacies", latitude: 37.7730, longitude: -122.4200, color: .yellow),
        Place(name: "Chai Spot", description: "Tea & snacks", latitude: 37.7770, longitude: -122.4160, color: .brown),
        Place(name: "Sandwich Stop", description: "Fresh sandwiches", latitude: 37.7800, longitude: -122.4110, color: .gray),
        Place(name: "Night Bites", description: "Late night food", latitude: 37.7650, longitude: -122.4350, color: .black)
    ]
    var routeCoordinates: [CLLocationCoordinate2D] {
        items.map { $0.coordinate }
    }
    
    @State private var selectedPlace: Place?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    
    
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                // 📍 Pins
                ForEach(items) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        VStack(spacing: 4) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundStyle(place.color)
                            
                            Text(place.name)
                                .font(.caption2)
                                .padding(4)
                                .background(.white, in: RoundedRectangle(cornerRadius: 6))
                        }
                        .onTapGesture {
                            selectedPlace = place
                            withAnimation {
                                cameraPosition = .region(
                                    MKCoordinateRegion(
                                        center: place.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                    )
                                )
                            }
                        }
                    }
                }
                // 🛣️ Polyline (Path)
                MapPolyline(coordinates: routeCoordinates)
                    .stroke(.blue, lineWidth: 4)
            }
            .mapStyle(.standard)
            .ignoresSafeArea()
        }.onAppear(perform: {
            fitAllLocations()
            showSheet.toggle()
        })
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
                            ForEach(items) { place in
                                HStack(spacing: 14) {
                                    
                                    // 📍 Icon (Pin style instead of weather icon)
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(place.color.opacity(0.15))
                                            .frame(width: 46, height: 46)
                                        
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundStyle(place.color)
                                    }
                                    
                                    // 📄 Info
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(place.name)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                        Text(place.description)
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                            .lineLimit(1)
                                        
                                        // 👉 Show coordinates (NEW)
                                        Text("Lat: \(place.latitude), Lon: \(place.longitude)")
                                            .font(.caption2)
                                            .foregroundStyle(.gray.opacity(0.7))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(.gray.opacity(0.6))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(
                                    selectedPlace?.id == place.id
                                    ? place.color.opacity(0.15)
                                    : Color(.secondarySystemBackground),
                                    in: RoundedRectangle(cornerRadius: 12)
                                )
                                
                                // 🎯 Tap → Move Map Camera
                                .onTapGesture {
                                    selectedPlace = place
                                    
                                    withAnimation {
                                        cameraPosition = .region(
                                            MKCoordinateRegion(
                                                center: place.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                            )
                                        )
                                    }
                                }
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
                titleHeight == .zero
                ? [.fraction(0.25), .medium, .large]
                : [.height(titleHeight), .fraction(0.5), .large]
            )
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.visible)
        }
    }
    func fitAllLocations() {
        let lats = items.map { $0.latitude }
        let longs = items.map { $0.longitude }
        
        guard let minLat = lats.min(),
              let maxLat = lats.max(),
              let minLon = longs.min(),
              let maxLon = longs.max() else { return }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLon - minLon) * 1.5
        )
        
        cameraPosition = .region(MKCoordinateRegion(center: center, span: span))
    }
}
