//
//  ContentView.swift
//  Simple Estimation Tool
//
//  Created by Enciso Systems on 1/04/24.
//

import SwiftUI

struct EstimationToolView: View {
    @State private var textState = ""
    @State private var estimations = ""
    @State private var showEstimations = false
    @State private var showAlert = false
    @State private var isLoading = false
    @State private var isSmart = false
    @State private var showCopyConfirmation = false

    private var estimationApi = EstimationApi()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Text("Simple Estimation Tool")
                    .font(.headline)
                Spacer() // Pushes everything to center
                
                VStack(spacing: 16) {
                    
                    TextField("Ingrese su objetivo", text: $textState)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if isLoading {
                        ProgressView("Estimando...")
                    }
                    else {
                        Button("Estimar") {
                            if textState.isEmpty {
                                showAlert = true
                            } else {
                                isLoading = true
                                showEstimations = false
                                estimationApi.getEstimations(task: textState) { response, error in
                                    isLoading = false
                                    if let response = response {
                                        if response.smart {
                                            isSmart = true
                                            let tasks = response.estimation.tasks.map { "\($0.task) - Estimado: \($0.estimated_hours) horas" }
                                            estimations = tasks.joined(separator: "\n")
                                            estimations += "\n\nTotal estimado: \(response.estimation.tasks.reduce(0) { $0 + $1.estimated_hours }) horas"
                                        } else {
                                            isSmart = false
                                            let tasks = response.estimation.tasks.map { $0.task }
                                            estimations = tasks.joined(separator: "\n")
                                        }
                                        showEstimations = true
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    if showEstimations {
                        ScrollView {
                            VStack {
                                Text(estimations)
                                    .padding()
                                    .multilineTextAlignment(.center) // Centers the text within the Text view
                                // Show the copy button only if the task is smart
                                if isSmart {
                                    Button(action: {
                                        UIPasteboard.general.string = estimations
                                        showCopyConfirmation = true  // Show confirmation when copied
                                    }) {
                                        Image(systemName: "doc.on.doc")  // Only the copy symbol
                                            .font(.title2)  // Optional: Adjust the size of the symbol
                                    }
                                    .padding()
                                    .buttonStyle(.bordered)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alerta"), message: Text("Por favor, ingrese una tarea antes de obtener la estimación."), dismissButton: .default(Text("OK")))
        }
        .alert("Copiado", isPresented: $showCopyConfirmation) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Las estimaciones han sido copiadas al portapapeles.")
        }
        .padding()
    }
}

#Preview {
    EstimationToolView()
}
