//
//  CardfitApp.swift
//  Cardfit
//
//  Created by 서동운 on 5/26/23.
//

import SwiftUI
import FirebaseFirestoreSwift

@main
struct CardfitApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var mainModel = MainViewModel()
    @State var isLoaded = false

    var body: some Scene {
        WindowGroup {
            if isLoaded {
                Main()
                    .environmentObject(mainModel)
            } else {
                LaunchScreen(percent: 0, isLoaded: $isLoaded)
            }
        }
    }
}
