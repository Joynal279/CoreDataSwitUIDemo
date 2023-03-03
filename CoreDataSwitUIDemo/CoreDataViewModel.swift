//
//  CoreDataViewModel.swift
//  CoreDataSwitUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//
import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [SubjectEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "SubjectsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading core data: \(error)")
            }else{
                print("successfully loaded core data.")
            }
        }
        fetchSubject()
    }
    
    //Retrive Data
    func fetchSubject(){
        let request = NSFetchRequest<SubjectEntity>(entityName: "SubjectEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Add Data
    func addSubject(text: String){
        let newSubject = SubjectEntity(context: container.viewContext)
        newSubject.name = text
        saveData()
    }
    
    //Save Data
    func saveData(){
        do {
            try container.viewContext.save()
            fetchSubject()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Delete Data
    func deleteSubject(index: IndexSet) {
        guard let index = index.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    //Update Data
    func updateSubject(entity: SubjectEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + " _updated "
        entity.name = newName
        saveData()
    }
    
}
