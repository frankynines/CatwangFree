//
//  ContentView.swift
//  CatWang2026
//
//  Created by Bradley Anderson on 1/8/26.
//

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let nav = UIStoryboard(name: "MainStoryboard", bundle: .main).instantiateInitialViewController() as! UINavigationController
        return nav.topViewController as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct ContentView: View {
    var body: some View {
            ViewControllerRepresentable()
    }
}

#Preview {
    ContentView()
}
