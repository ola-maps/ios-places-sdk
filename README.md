## Ola Map Services
This iOS SDK is designed to be robust, user-friendly, and easy to integrate into any application. By providing powerful features like Autocomplete, Forward Geocoding, Reverse Geocoding and NearbySearch, along with capabilities like configurable retry logic and automatic token refresh, this SDK is a comprehensive solution for place-related functionalities.

Designed to be lightweight, easy to integrate, this SDK ensures users have a seamless experience. It also includes periodic updates, making it highly reliable and user-friendly.

## Installation
You have to Download OlaMapService SDK and import  the xcframework in your iOS project. Make sure you embed all the frameworks in General > Frameworks, Libraries and Embedded Content to the target.

## Features
* Autocomplete
* Forward Geocode
* Reverse Geocode
* Place Details
* Nearby Search
* Text Search

## Setup
First you need to import OlaMapService in your project, and then initialise PlacesService



```swift
let placesService = PlacesService(authKey: API_KEY, baseURL: BASE_URL)
```
## Autocomplete
An Autocomplete API provides real-time suggestions to users as they type in a search bar or input field. It enhances user experience by predicting possible completions based on partial input, leveraging databases or external data sources. This API is essential for search engines, e-commerce sites, and data-entry applications.

```swift
/// Autocomplete search APi
/// - Parameters:
///   - query: Search any place
///   - location: Provide the current location
///   - onCompletion: <AutoCompleteResponseModel, OlaServiceError>
func autocomplete(query: String, location: CLLocationCoordinate2D?) {
    placesService.autoCompleteResults(query: query, location: location) { result in
        switch result {
        case .success(let success):
            print("sucess = \(success)")
        case .failure(let failure):
            print("failure = \(failure.message)")
        }
    }
}
```

## Forward Geocode
A Forward Geocoding API converts human-readable addresses into geographic coordinates (latitude and longitude). This API is vital for mapping services, location-based applications, and logistics, enabling users to input an address and receive precise location data for navigation, spatial analysis, and geolocation services.

```swift
/// Forward geocode
/// - Parameters:
///   - address: Enter the address you want to search
///   - language: Select the language you want. Default is english
///   - onCompletion: Result<ForwardGeocodeResponseModel, OlaServiceError>)
func forwardGeocode(address: String) {
    placesService.forwardGeocode(address: address) { result in
        switch result {
        case .success(let success):
            print("sucess = \(success)")
        case .failure(let failure):
            print("failure = \(failure.message)")
        }
    }
}
 ```

## Reverse Geocode
A Reverse Geocoding API transforms geographic coordinates (latitude and longitude) into human-readable addresses. This API is crucial for mapping applications, location-based services, and navigation systems, allowing users to obtain address details from a specific location point, facilitating user-friendly interfaces and enhanced location tracking.

```swift
/// Reverse Geocoding
/// - Parameters:
///   - latlng: Provide the location latitude and longitude with comma(,)separated formated.
///       - Ex: let latlng = "\(Latitude),\(Longitude)"
///   - onCompletion: <ReverseGeocodeResponseModel, OlaServiceError>
func reverseGeocode(latlng: String) {
  placesService.reverseGeocoding(latlng: latlng) { result in
      switch result {
          case .success(let success):
              print("sucess = \(success)")
          case .failure(let failure):
              print("failure = \(failure.message)")
      }
    }
}
```

## Place Details
A Place Details API provides comprehensive information about a specific location, such as its name, address, contact details, opening hours, and user reviews. This API is essential for travel apps, local directories, and location-based services, enhancing user experience by offering detailed data on places of interest.

 ```swift
/// Get place details
/// - Parameters:
///   - placeId: provide the place id. You will get place_id from the autocomple search API or NearbySearch API response.
///   - onCompletion: <PlaceDetailsResponseModel, OlaServiceError>
func placeDetails(placeId: String) {
    placesService.getPlaceDetails(placeId: placeId) { result in
        switch result {
        case .success(let success):
            print("success = \(success)")
        case .failure(let failure):
            print("failure = \(failure.message)")
        }
    }
}
```

## NearbySearch
A Nearby Search API allows users to find points of interest within a specified radius from a given location. This API is essential for travel apps, local business directories, and location-based services, helping users discover nearby restaurants, shops, landmarks, and other amenities based on their current or specified location.

```swift
/// NearBy search
/// - Parameters:
///   - types: Available category types:
///          • restaurant
///          • parking
///          • gas_station
///          • toilet
///          • lodging
///          • bank
///          • hospital
///   - location: Provide the current location coordintes
///   - onCompletion: <AutoCompleteResponseModel, OlaServiceError>
func nearbyPlaces(categoryName: String) {  
    placesService.getNearbySearch(categoryName, locationCoordinate: CLLocationCoordinate2D) { result in
        switch result {
        case .success(let success):
            print("success = \(success)")
        case .failure(let failure):
            print("failure = \(failure.message)")
        }
    }
}
```

## TextSearch
The Places Text Search returns a list of places based on an input query. For eg: "Cafes in Koramangala" or "Restaurants near Bangalore" or "Ola Electric". This is a web service that responds with a list of Places.


```swift
/// Text Search API
/// - Parameters:
///   - input: Search for the popular places
///       -  Example: Cafes in Koramangala, Cinemas in Koramangala etc...
///   - location: Optionally, you can specify a location to search around that particular location.
///   - onCompletion: Result<TextSearchResponseModel, OlaServiceError>
func textSearchAPI(input: String, location: CLLocationCoordinate2D?, onCompletion: @escaping (_ result: Result<TextSearchResponseModel, OlaServiceError>) -> Void) {
    placesService.getTextSearch(input: input, location: location, onCompletion: { result in
        switch result {
        case .success(let success):
            print("success = \(success)")
        case .failure(let failure):
            print("failure = \(failure.message)")
        }
    })
}
```
