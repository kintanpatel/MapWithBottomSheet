//
//  MapViewModel.swift
//  Journey
//
//  Created by AK on 26/03/26.
//


import SwiftUI
import MapKit
import Combine
final class MapViewModel: ObservableObject {
    
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var cameraPosition: MapCameraPosition
    
    init() {
        let places = Self.mockData
        
        self.places = places
        self.cameraPosition = .region(
            MKCoordinateRegion(
                center: places.first?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
        
        fitAllLocations()
    }
    
    var routeCoordinates: [CLLocationCoordinate2D] {
        places.map { $0.coordinate }
    }
    
    func selectPlace(_ place: Place) {
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
    
    func fitAllLocations() {
        let lats = places.map { $0.latitude }
        let longs = places.map { $0.longitude }
        
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

// MARK: - Mock Data
extension MapViewModel {
    static let mockData: [Place] = [
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
}
