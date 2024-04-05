//
//  estimationApi.swift
//  Simple Estimation Tool
//
//  Created by Enciso Systems on 1/04/24.
//

import Foundation
import SwiftUI
import UIKit

struct ApiResponse: Codable {
    let smart: Bool
    let estimation: Estimation
}

struct Task: Codable {
    let task: String
    let estimated_hours: Double
}

struct Estimation: Codable {
    let tasks: [Task]
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

class EstimationApi {
    func getEstimations(task: String, completion: @escaping (ApiResponse?, Error?) -> Void) {
        let baseUrl = "http://18.221.34.229/API/chat?task=\(task)"
        guard let url = URL(string: baseUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data)
            completion(apiResponse, nil)
        }.resume()
    }
}
