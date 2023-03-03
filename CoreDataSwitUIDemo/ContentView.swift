//
//  ContentView.swift
//  CoreDataSwitUIDemo
//
//  Created by Joynal Abedin on 4/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm: CoreDataViewModel = CoreDataViewModel()
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add subject which you like!")
                TextField("Add subject here", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.cyan)
                    .cornerRadius(19)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else {return}
                    vm.addSubject(text: "📕" + textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
                Spacer()
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "no name")
                            .onTapGesture {
                                vm.updateSubject(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteSubject)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Subject List")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
