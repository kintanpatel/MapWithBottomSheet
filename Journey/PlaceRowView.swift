//
//  PlaceRowView.swift
//  Journey
//
//  Created by AK on 26/03/26.
//


import SwiftUI

struct PlaceRowView: View {
    let place: Place
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 14) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(place.color.opacity(0.15))
                    .frame(width: 46, height: 46)
                
                Image(systemName: "mappin.circle.fill")
                    .foregroundStyle(place.color)
            }
            
            VStack(alignment: .leading) {
                Text(place.name).font(.subheadline).bold()
                Text(place.description).font(.caption).foregroundStyle(.gray)
                Text("Lat: \(place.latitude), Lon: \(place.longitude)")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(
            isSelected ? place.color.opacity(0.15) : Color(.secondarySystemBackground),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}