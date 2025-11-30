//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Abdallah Adel on 29/01/2025.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case viewCode
    case creator

    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .viewCode:
            return URL(string: "https://github.com/pcpos")
        case .creator:
            return URL(string: "https://github.com/pcpos")
        }
    }

    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .viewCode:
            return "View Source Code"
        case .creator:
            return "Created by Abdallah Adel"
        }
    }
    
    var displaySubtitle: String? {
        switch self {
        case .creator:
            return "iOS Developer, 22 y/o"
        default:
            return nil
        }
    }

    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return LiquidGlassTheme.portalBlue
        case .viewCode:
            return LiquidGlassTheme.portalGreen
        case .creator:
            return LiquidGlassTheme.cosmicPurple
        }
    }

    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .viewCode:
            return UIImage(systemName: "chevron.left.forwardslash.chevron.right")
        case .creator:
            return UIImage(systemName: "person.crop.circle.fill")
        }
    }
}
