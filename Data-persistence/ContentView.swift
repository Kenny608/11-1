//
//  ContentView.swift
//  Data-persistence
//
//  Created by Kenny Luchau on 11/1/23.
//
//  yes?

import SwiftUI
class UserSettings: ObservableObject {
    @Published var isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode") {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
}
struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    let coreDM: CoreDataManager
    @State var gameName = ""
    @State var gameDeveloper = ""
    @State var gamePublisher = ""
    @State var gameArray = [Game]()
    var body: some View {
        VStack {
            TextField("Enter game name", text: $gameName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter developer", text: $gameDeveloper)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter publisher", text: $gamePublisher)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                coreDM.saveGame(name: gameName, developer: gameDeveloper, publisher: gamePublisher)
                displayGames()
                gameName = ""
                gameDeveloper = ""
                gamePublisher = ""
            }
            List {
                ForEach(gameArray, id: \.self) { game in
                    VStack {
                        Text(game.name ?? "")
                        Text(game.developer ?? "")
                        Text(game.publisher ?? "")
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let game = gameArray[index]
                        coreDM.deleteGame(game: game)
                        displayGames()
                    }
                })
            }
            
            
            
            Spacer()
        }.padding()
            .onAppear(perform: {
                displayGames()
            })
            .preferredColorScheme(userSettings.isDarkMode ? .dark : .light)
    }
    func displayGames() {
        gameArray = coreDM.getAllGames()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
