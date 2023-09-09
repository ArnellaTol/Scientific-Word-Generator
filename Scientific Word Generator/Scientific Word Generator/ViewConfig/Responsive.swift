//
//  Responsive.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 21.12.2022.
//  Copyright © 2022 Asel Zhanbekova. All rights reserved.
//

import SwiftUI

struct ResponsiveView<Content: View>: View {
    var content: (Properties) -> Content
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isPad = UIDevice.current.userInterfaceIdiom == .pad
            
            content(Properties(isPad: isPad, size: size))
                .frame(width: size.width, height: size.height, alignment: .center )
        }
    }
}

struct Properties {
    var isPad: Bool
    var size: CGSize
}
