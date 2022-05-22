//
//  UIViewController+Storyboard.swift
//  MoviesX
//
//  Created by Mufakkharul Islam Nayem on 17/5/22.
//

import UIKit

/// Adds ability to any conforming view controller to be instantiated easily provided that the storybord identifier is same as the class name of that said view controller.
protocol StoryboardInstantiable: AnyObject {
    
    /// Adds the ability for conforming class to have an associated Storyboard name.
    ///
    /// - note: Look at `UIStoryboard.Name` for available names.
    static var storyboardName: UIStoryboard.Name { get }
    
    /// Adds the ability for conforming class that can be instantiated from Storyboard given that the Storyboard ID is same as the class name.
    ///
    /// Default implementation available.
    /// - Returns: A fully initialized class from Storyboard.
    static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiable {
    
    static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper()
    }
    
    private static func instantiateFromStoryboardHelper<T>() -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError()
        }
        return controller
    }
    
}
