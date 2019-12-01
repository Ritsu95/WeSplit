//
//  ContentView.swift
//  WeSplit
//
//  Created by Ritsu on 01/12/2019.
//  Copyright © 2019 Ritsu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Variables for the UI
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Calculate the total per person
    var totalPerPerson: Double {
       // Getting all the variables to Doubles
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        // Calculate percentage, add it to the amount and spread it among the people
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                // 1st Section: amount + people to divide
                Section {
                    TextField("Cantidad", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Cantidad de personas", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) personas")
                        }
                    }
                }
                
                // 2nd Section: tip percentage
                Section (header: Text("¿Cuánta propina quieres dar?")){
                    Picker("Porcentaje de la propina", selection: $tipPercentage) {
                            ForEach(0 ..< tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                // 3rd Section: total
                Section (header: Text("Total por persona")) {
                    Text("\(totalPerPerson, specifier: "%.2f")€")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
