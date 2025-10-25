//
//  AllAppsView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/23/25.
//

import SwiftUI
import SwiftfulRouting

struct AllAppsView: View {
    @Environment(\.router) var router
    
    var body: some View {
        NavigationStack {
            List {
                Button("Open Spotifiy") {
                    router.showScreen(.fullScreenCover) { _ in
                        SpotifiyHomeView()
                    }
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        AllAppsView()
    }
}
