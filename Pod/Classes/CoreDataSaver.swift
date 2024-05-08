//
//  CoreDataSaver.swift
//  Pods
//
//  Copyright © 2020 Evgenii Ivanov. All rights reserved.
//

import Foundation
import MagicalRecord

public typealias CoreDataSaverSavingBlock = (_ localContext : NSManagedObjectContext, _ cancelSaving: inout Bool) -> Void
public typealias CoreDataSaverCompletionBlock = () -> Void
public typealias CoreDataSaverCompletionWithObjectIdsBlock = (_ objects: [String]) -> Void

@objc open class CoreDataSaver: NSObject {
    
    public static let sharedInstance = CoreDataSaver()
    
    let savingQueue = OperationQueue()
    
    private override init() {
        super.init()
        savingQueue.name = "CoreDataSaver_queue"
        savingQueue.maxConcurrentOperationCount = 1
    }
    
    open func saveData(_ savingBlock: @escaping CoreDataSaverSavingBlock,
                       success: @escaping CoreDataSaverCompletionBlock) -> Void {
        savingQueue.addOperation( {
            var cancelSaving = false
            
            MagicalRecord.save(blockAndWait: { (localContext) in
                savingBlock(localContext, &cancelSaving)
                
                if cancelSaving {
                    localContext.rollback()
                }
            })
            
            if !cancelSaving {
                DispatchQueue.main.async() {
                    success()
                }
            }
        })
    }
    
    open func saveData(_ savingBlock: @escaping CoreDataSaverSavingBlock, objectUidKey: String,
                       successWithObjectIds: @escaping CoreDataSaverCompletionWithObjectIdsBlock) -> Void {
        savingQueue.addOperation( {
            var cancelSaving = false
            
            var objectIds = [String]()
            
            MagicalRecord.save(blockAndWait: { (localContext : NSManagedObjectContext!) in
                savingBlock(localContext, &cancelSaving)
                
                if cancelSaving {
                    localContext.rollback()
                } else {
                    for obj in localContext.insertedObjects {
                        if let uid = obj.value(forKey: objectUidKey), uid is String {
                            objectIds.append(uid as! String)
                        }
                    }
                    for obj in localContext.updatedObjects {
                        if let uid = obj.value(forKey: objectUidKey), uid is String {
                            objectIds.append(uid as! String)
                        }
                    }
                }
            })
            
            if !cancelSaving {
                DispatchQueue.main.async() {
                    successWithObjectIds(objectIds)
                }
            }
        })
    }
}
