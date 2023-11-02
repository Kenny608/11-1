//
//  Data_persistenceApp.swift
//  Data-persistence
//
//  Created by Kenny Luchau on 11/1/23.
//

import SwiftUI

@main
struct Data_persistenceApp: App {
    @State private var darkmode = UserDefaults.standard.bool(forKey: "Toggle")
    var body: some Scene {
        WindowGroup {
            ContentView() .preferredColorScheme(darkmode ? .dark : .light)
        }
    }
}
