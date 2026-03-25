//
//  Place.swift
//  Journey
//
//  Created by AK on 25/03/26.
//

import Foundation
import MapKit
import SwiftUI

struct Place: Identifiable,Equatable {
    let id = UUID()
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let color: Color
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
