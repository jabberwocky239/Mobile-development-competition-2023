//
//  Categories.swift
//  VCCup2023
//
//  Created by Maxım Gaıssın on 18.12.2022.
//

import Foundation

enum Category: CaseIterable {
    case humor, food, moovies, restaurants, walks, politics, news, auto, tvSeries, foodReciepts, work, recreation, sports
    
    var description: String {
        switch self {
        case .humor:
            return "Humor"
        case .food:
            return "Food"
        case .moovies:
            return "Movies"
        case .restaurants:
            return "Restaurants"
        case .walks:
            return "Walks"
        case .politics:
            return "Politics"
        case .news:
            return "News"
        case .auto:
            return "Auto"
        case .tvSeries:
            return "TV-Series"
        case .foodReciepts:
            return "Food reciepts"
        case .work:
            return "Work"
        case .recreation:
            return "Recreation"
        case .sports:
            return "Sports"
        }
    }
}
