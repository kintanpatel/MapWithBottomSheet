# 🗺️ Journey – Map & Route Explorer (SwiftUI)

A modern SwiftUI demo showcasing **MapKit integration**, **interactive bottom sheet**, and **synchronized list + map experience** — similar to apps like Google Maps or Apple Maps.

---

## ✨ Features

* 📍 **Multiple Map Annotations**

  * Display dynamic locations (restaurants, places, etc.)

* 🛣️ **Polyline Route Drawing**

  * Connect all locations visually on the map

* 📜 **Interactive Bottom Sheet**

  * Custom detents (dynamic height + multi states)
  * Smooth drag interaction
  * Background map remains interactive

* 🔄 **Map ↔ List Synchronization**

  * Tap list → camera moves to location
  * Tap pin → list highlights & auto-scrolls

* 🎯 **Auto Camera Adjustment**

  * Fits all locations on initial load

* 🧱 **Clean Architecture (MVVM)**

  * Separation of concerns
  * Scalable & production-ready structure

---

## 📱 Preview

> Interactive map with draggable bottom sheet and synced location list

---

## 🏗️ Project Structure

```
📁 Journey
 ┣ 📄 ContentView.swift        // Entry point + Sheet handling
 ┣ 📄 MapView.swift            // Map + Annotations + Polyline
 ┣ 📄 BottomSheetView.swift    // List UI inside sheet
 ┣ 📄 PlaceRowView.swift       // Reusable list item
 ┣ 📄 MapViewModel.swift       // Business logic (MVVM)
 ┗ 📄 Place.swift              // Data model
```

---

## 🚀 Getting Started

### Requirements

* iOS 17+
* Xcode 15+
* Swift 5.9+

### Run the Project

1. Clone the repository

```bash
git clone https://github.com/your-username/journey.git
```

2. Open in Xcode
3. Build & Run on Simulator or Device

---

## 🧠 Key Concepts Used

* **SwiftUI MapKit**

  * `Map`, `Annotation`, `MapPolyline`

* **Bottom Sheet APIs**

  * `.presentationDetents`
  * `.presentationBackgroundInteraction`

* **Scroll Synchronization**

  * `ScrollViewReader`
  * `.onChange(of:)`

* **GeometryReader**

  * Dynamic height calculation for custom detents

* **MVVM Architecture**

  * `ObservableObject` + `@Published`

---

## ⚙️ Customization Ideas

* 🔍 Add search functionality (MapKit / Google Places API)
* 📡 Load real-time data from backend
* 🚗 Show navigation routes (MapKit Directions API)
* 📍 Add clustering for large datasets
* 🧭 Show user location & distance

---

## 📸 Future Enhancements

* Apple Maps-style **floating cards**
* Animated route tracking (vehicle movement)
* Filtering & categories (Food, Cafe, etc.)
* Dark mode optimized UI

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 🙌 Author

Developed with ❤️ using SwiftUI & MapKit
