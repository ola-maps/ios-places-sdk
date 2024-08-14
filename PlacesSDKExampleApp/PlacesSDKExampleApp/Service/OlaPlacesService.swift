//
//  OlaPlacesService.swift
//  OlaMapServicesExample
//
//  Created by Zeeshan Khundmiri on 02/08/24.
//

import Foundation

import Foundation
import OlaMapServices
import CoreLocation


final class OlaPlacesService {
    
    // Add Auth key
    // Add base URL
    private let placesService = PlacesService(authKey: AppUtility.getAPIKey(), baseURL: AppUtility.getBaseURL())
 
    func autocomplete(query: String, location: CLLocationCoordinate2D?, onCompletion: @escaping (_ result: Result<AutoCompleteResponseModel, OlaServiceError>) -> Void) {
        placesService.autoCompleteResults(query: query, location: location) { result in
            switch result {
            case .success(let success):
                onCompletion(.success(success))
               debugPrint("autocomplete sucess = \(success)")
            case .failure(let failure):
                onCompletion(.failure(failure))
                debugPrint("autocomplete failure = \(failure)")
            }
        }
    }
    
    func placeDetails(placeId: String, onCompletion: @escaping (_ result: Result<PlaceDetailsResponseModel, OlaServiceError>) -> Void) {
        placesService.getPlaceDetails(placeId: placeId) { result in
            switch result {
            case .success(let success):
                onCompletion(.success(success))
                debugPrint("placeDetails sucess = \(success)")
            case .failure(let failure):
                onCompletion(.failure(failure))
                debugPrint(" placeDetails failure = \(failure)")
            }
        }
    }
   // CLLocation(latitude: 12.93145226827615, longitude: 77.61645030596725)
    func nearbyPlaces(categoryName: String, locationCoordinate: CLLocationCoordinate2D, onCompletion: @escaping (_ result: Result<AutoCompleteResponseModel, OlaServiceError>) -> Void) {
        // available category types:
        //restaurant
        // parking
        // gas_station
        // lodging
        // bank
        // hospital
        placesService.getNearbySearch(categoryName, locationCoordinate: locationCoordinate) { result in
            switch result {
            case .success(let success):
                debugPrint("geNearbySearch sucess = \(success)")
                onCompletion(.success(success))
            case .failure(let failure):
                debugPrint("getNearbySearch failure = \(failure)")
                onCompletion(.failure(failure))
            }
        }
    }
    
    func reverseGeocode(latlng: String, onCompletion: @escaping (_ result: Result<ReverseGeocodeResponseModel, OlaServiceError>) -> Void) {
        placesService.reverseGeocoding(latlng: latlng) { result in
            switch result {
            case .success(let success):
                debugPrint("reverseGeocode sucess = \(success)")
                onCompletion(.success(success))
            case .failure(let failure):
                debugPrint("reverseGeocode failure = \(failure)")
                onCompletion(.failure(failure))
            }
        }
    }
    
    func forwardGeocode(address: String, onCompletion: @escaping (_ result: Result<ForwardGeocodeResponseModel, OlaServiceError>) -> Void) {
        
        placesService.forwardGeocode(address: address) { result in
            switch result {
            case .success(let success):
                debugPrint("geocode sucess = \(success)")
                onCompletion(.success(success))
            case .failure(let failure):
                debugPrint("geocode failure = \(failure)")
                onCompletion(.failure(failure))
            }
        }
    }
    
    func textSearchAPI(input: String, location: CLLocationCoordinate2D?, onCompletion: @escaping (_ result: Result<TextSearchResponseModel, OlaServiceError>) -> Void) {
        
        placesService.getTextSearch(input: input, location: location, onCompletion: { result in
            switch result {
            case .success(let success):
                debugPrint("textSearchAPI sucess = \(success)")
                onCompletion(.success(success))
            case .failure(let failure):
                debugPrint("textSearchAPI message = \(failure)")
                onCompletion(.failure(failure))
            }
        })
    }

}
