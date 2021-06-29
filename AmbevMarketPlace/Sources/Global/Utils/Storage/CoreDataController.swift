//
//  CoreDataController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 24/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController {
    
    static let share = CoreDataController()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AmbevMarketPlace")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    func save(request: BrowseProducts.Model.Request, completion: @escaping (Result<Bool, NSError>) -> ()) {
        let entity = OrderedProducts(context: self.context)
        entity.productId = request.id
        entity.quantity = request.quantity

        self.context.insert(entity)
        do {
            try self.context.save()
            completion(.success(true))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }

    func update(request: BrowseProducts.Model.Request, completion: @escaping (Result<Bool, NSError>) -> ()) {
        let entity = OrderedProducts(context: self.context)
        entity.productId = request.id
        entity.quantity = request.quantity
        do {
            try self.context.save()
            completion(.success(true))
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }

    func fetch(completion: @escaping (Result<[OrderedProducts], CustomError>) -> ()) {
        do {
            let results = try self.context.fetch(OrderedProducts.fetchRequest() as NSFetchRequest<OrderedProducts>)
            completion(.success(results))
        } catch {
            completion(.failure(.noData))
        }
    }

    func fetch(with id: String) throws -> OrderedProducts? {
        let request = NSFetchRequest<OrderedProducts>(entityName: "OrderedProducts")
        request.predicate = NSPredicate(format: "productId == %@", id)
        
        do {
            return try self.context.fetch(request).first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    func delete(request: BrowseProducts.Model.Request) {
        let fetchRequest: NSFetchRequest<OrderedProducts> = OrderedProducts.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "productId==\(request.id)")
        guard let objects = try? self.context.fetch(fetchRequest) else { return }
        objects.forEach({context.delete($0)})
        
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
