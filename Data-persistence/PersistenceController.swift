//
//  PersistenceController.swift
//  Data-persistence
//
//  Created by Kenny Luchau on 11/8/23.
//

import Foundation
import CoreData
class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        }
    }
    func deleteGame(game: Game) {
        persistentContainer.viewContext.delete(game)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }



    func getAllGames() -> [Game] {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    func saveGame(name: String, developer: String, publisher: String) {
        let game = Game(context: persistentContainer.viewContext)
        game.name = name
        game.developer = developer
        game.publisher = publisher
        do {
            try persistentContainer.viewContext.save()
            print("Game saved!")
        } catch {
            print("Failed to save game \(error)")
        }
    }
}
