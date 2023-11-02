//
//  ContentView.swift
//  Data-persistence
//
//  Created by Kenny Luchau on 11/1/23.
//
// Currently wont actively update the view / dark mode.
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorscheme
    @State private var darkMode = false
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack (spacing: 40){
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text(colorscheme == .dark ? "In dark" : "In light")
            
            Toggle(isOn: $darkMode, label: {
                Text("Dark Mode")

            })
            
            Button(action: {
                UserDefaults.standard.set(darkMode, forKey: "Toggle")
                
            }) {
                Text("Save data")
            }
            Button(action: {
                           darkMode = UserDefaults.standard.bool(forKey: "Toggle")
                       }) {
                           Text("Retrieve data")
                       }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
