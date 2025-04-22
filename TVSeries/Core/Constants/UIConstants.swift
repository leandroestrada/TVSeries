//
//  UIConstants.swift
//  TVSeries
//
//  Created by leandro estrada on 21/04/25.
//

import UIKit

enum UIConstants {
    
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
    }
    
    enum ShowsList {
        static let cellHeight: CGFloat = 106
        static let imageWidth: CGFloat = 60
        static let imageHeight: CGFloat = 90
        static let separatorInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    enum ShowDetails {
        static let posterWidth: CGFloat = 240
        static let posterHeight: CGFloat = 360
        static let titleFontSize: CGFloat = 24
        static let regularFontSize: CGFloat = 16
        static let episodeCellHeight: CGFloat = 72
    }
    
    enum EpisodeDetails {
        static let imageAspectRatio: CGFloat = 9/16
    }
    
    enum EpisodeCell {
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 56
        static let titleFontSize: CGFloat = 16
        static let subtitleFontSize: CGFloat = 14
    }
    
    enum Font {
        static let title = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let subtitle = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 16)
        static let caption = UIFont.systemFont(ofSize: 14)
    }
    
}
