//
//  Extentions.swift
//  RickAndMorty
//
//  Created by Abdallah Adel on 03/05/2024.
//

import Foundation
import UIKit

// MARK: - UIView Extensions

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - Safe Blur View Helper

/// Creates a blur view with fallback for reduced transparency mode
func createSafeBlurView(style: UIBlurEffect.Style = .systemThinMaterial) -> UIView {
    if !UIAccessibility.isReduceTransparencyEnabled {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    } else {
        // Fallback for reduce transparency
        let fallbackView = UIView()
        fallbackView.backgroundColor = UIColor.secondarySystemBackground
        fallbackView.translatesAutoresizingMaskIntoConstraints = false
        return fallbackView
    }
}

/// Helper to get the content view for labels (works with both blur and fallback)
func getContentView(from view: UIView) -> UIView {
    if let blurView = view as? UIVisualEffectView {
        return blurView.contentView
    }
    return view
}

// MARK: - Liquid Glass Theme Colors

enum LiquidGlassTheme {
    
    // Primary accent colors with Rick and Morty theme
    static let portalGreen = UIColor(red: 0.0, green: 0.85, blue: 0.45, alpha: 1.0)
    static let portalBlue = UIColor(red: 0.2, green: 0.75, blue: 1.0, alpha: 1.0)
    static let cosmicPurple = UIColor(red: 0.55, green: 0.3, blue: 0.95, alpha: 1.0)
    static let dimensionPink = UIColor(red: 1.0, green: 0.4, blue: 0.6, alpha: 1.0)
    
    // Glass tints
    static let glassTintLight = UIColor.white.withAlphaComponent(0.15)
    static let glassTintDark = UIColor.black.withAlphaComponent(0.2)
    
    // Gradient colors for glass highlights
    static var glassGradientColors: [CGColor] {
        return [
            UIColor.white.withAlphaComponent(0.25).cgColor,
            UIColor.white.withAlphaComponent(0.05).cgColor,
            UIColor.clear.cgColor
        ]
    }
    
    // Status colors with glass effect
    static let aliveGlass = UIColor(red: 0.2, green: 0.9, blue: 0.4, alpha: 0.85)
    static let deadGlass = UIColor(red: 0.95, green: 0.3, blue: 0.3, alpha: 0.85)
    static let unknownGlass = UIColor(red: 0.6, green: 0.6, blue: 0.7, alpha: 0.85)
}

// MARK: - Navigation Bar Glass Style

extension UINavigationBar {
    
    func applyLiquidGlassStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        
        // Title styling
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
        
        // Subtle shadow line replacement
        shadowImage = UIImage()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.05
    }
}

// MARK: - Tab Bar Glass Style

extension UITabBar {
    
    func applyLiquidGlassStyle() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
        
        // Icon styling
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.secondaryLabel
        itemAppearance.selected.iconColor = LiquidGlassTheme.portalGreen
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: LiquidGlassTheme.portalGreen]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        
        // Floating effect with rounded corners
        layer.cornerRadius = 25
        layer.cornerCurve = .continuous
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Glass border on top
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -4)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.1
    }
}

// MARK: - UIView Glass Extensions

extension UIView {
    
    /// Apply liquid glass background effect
    func applyLiquidGlassBackground(
        cornerRadius: CGFloat = 16,
        blurStyle: UIBlurEffect.Style = .systemThinMaterial
    ) {
        backgroundColor = .clear
        
        // Remove existing glass views
        subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.tag = 999
        blurView.layer.cornerRadius = cornerRadius
        blurView.layer.cornerCurve = .continuous
        blurView.clipsToBounds = true
        
        insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Glass border
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        // Subtle shadow for depth
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.15
    }
}
