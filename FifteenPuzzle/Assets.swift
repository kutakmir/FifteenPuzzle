//
//  Assets.swift
//  FifteenPuzzle
//
//  Created by Miroslav Kutak on 10/29/2021.
//

import SwiftUI

enum AssetColors: String {
    case marbleBackround
}

extension Color {
    init(asset color: AssetColors) {
        self.init(color.rawValue)
    }
}
