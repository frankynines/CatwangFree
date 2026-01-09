//
//  ContentView.swift
//  CatWang2026
//
//  Created by Bradley Anderson on 1/8/26.
//

import SwiftUI


struct NavigationHostViewController: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = UINavigationController

    func makeUIViewController(context: Context) -> UINavigationController {
        return UIStoryboard(name: "MainStoryboard", bundle: .main).instantiateInitialViewController() as! UINavigationController
        
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update the view controller if needed, e.g., when SwiftUI state changes
    }
}

struct ContentView: View {
    var body: some View {
        NavigationHostViewController()
    }
}

#Preview {
    ContentView()
}
