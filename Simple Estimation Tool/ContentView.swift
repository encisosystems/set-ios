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
    @State private var showShareSheet = false

    private var estimationApi = EstimationApi()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Text("Enciso Estimation")
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
                    
/*
 Hacer una pagina en react con la frase hola mundo
 */
                    if showEstimations {
                        ScrollView {
                            VStack {
                                Text(estimations)
                                    .padding()
                                    .multilineTextAlignment(.center) // Centers the text within the Text view
                                // Show the copy button only if the task is smart
                                if isSmart {
                                    HStack {
                                        Button(action: {
                                            UIPasteboard.general.string = estimations
                                            showCopyConfirmation = true
                                        }) {
                                            Image(systemName: "doc.on.doc")
                                                .font(.title2)
                                        }
                                        .buttonStyle(.bordered)
                                        .padding()
                                        
                                        Button(action: {
                                            showShareSheet = true
                                        }) {
                                            Image(systemName: "square.and.arrow.up")
                                                .font(.title2)
                                        }
                                        .buttonStyle(.bordered)
                                        .padding()
                                        .sheet(isPresented: $showShareSheet, content: {
                                            ShareSheet(activityItems: [estimations])
                                        })
                                    }
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
